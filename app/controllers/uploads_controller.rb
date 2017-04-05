require 'csv'

class UploadsController < ApplicationController

  def upload
      uploaded_io = params[:csvfile]
      raw_csv = uploaded_io.read
      status = "Success"
      csv = []
      total_price = 0.00

      begin
        csv = CSV.parse(raw_csv, headers: true)
      rescue CSV::MalformedCSVError
        status = "Failure"
      end

      csv.each do |row|
        total_price += (row.fields[2].to_f * row.fields[3].to_f)
        normalize(row)
      end

      render "upload_result", locals: { total_price: total_price, status: status, grand_total: calculate_grand_total  }
  end

  def calculate_grand_total
    sql = "SELECT SUM(t.charge) AS total_charge FROM (SELECT p.quantity * i.price AS charge FROM purchases p, items i WHERE p.item_id = i.id) t;"
    result = ActiveRecord::Base.connection.execute(sql)
    result.first[0] || 0.00
  end

  def purge_and_reset
    system "rake db:drop"
    system "rake db:create"
    system "rake db:migrate"
  end

  # Displays overview of how csv file was normalized for visual debugging
  def overview
    render "overview",
    locals: {
      purchasers: Purchaser.all,
      items: Item.all,
      purchases: Purchase.all,
      merchants: Merchant.all,
      sales: Sale.all
    }
  end

  # Does the heavy lifting of breaking up CSV file into records
  def normalize(row)
    purchaser = Purchaser.find_by_name(row.fields[0])
    purchaser = Purchaser.create!({ name: row.fields[0] }) unless purchaser

    item = Item.find_by_description(row.fields[1])
    item = Item.create!({ description: row.fields[1], price: row.fields[2] }) unless item

    purchase = Purchase.new({ purchaser_id: purchaser.id, item_id: item.id, quantity: row.fields[3] })
    purchase.save!

    merchant = Merchant.find_by_name(row.fields[5])
    merchant = Merchant.create!({ name: row.fields[5], address: row.fields[4] }) unless merchant

    sale = Sale.new({ item_id: item.id, merchant_id: merchant.id})
    sale.save!
  end

  private :normalize
end

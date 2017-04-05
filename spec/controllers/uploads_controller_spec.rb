require 'rails_helper'

RSpec.describe UploadsController, type: :controller do
  render_views

  describe "GET /" do
    context "With an empty database" do
      before do
        get :index
        expect(response.status).to be(200)
      end

      it "should render the index page" do
        expect(response).to render_template("index")
      end

      it "should render a form" do
        html_doc = Nokogiri::HTML(response.body)
        expect(html_doc.xpath("//form").empty?).to be(false)
      end

      it "should make the form accept .csv files by default" do
        html_doc = Nokogiri::HTML(response.body)
        expect(html_doc.xpath("//input")[1].attributes["accept"].value).to eq(".csv")
      end

      it "should not display overview and purge links if DB is empty" do
        html_doc = Nokogiri::HTML(response.body)
        expect(html_doc.xpath("//a").count).to eq(0)
        expect(html_doc.xpath("//a").to_a).to eq([])
      end
    end

    context "With a non-empty database" do
      before do
        Purchaser.create!({ name: "Otto Kaufmann" })
        get :index
        expect(response.status).to be(200)
      end

      it "should display overview and purge links if DB contains records" do
        html_doc = Nokogiri::HTML(response.body)
        expect(html_doc.xpath("//a").count).to eq(2)
        expect(html_doc.xpath("//a").first.text).to eq("Normalization Overview")
        expect(html_doc.xpath("//a").last.text).to eq("Reset database (be patient!)")
      end
    end
  end

  describe "POST /upload" do
    context "With a valid csv file" do
      before do
        csv_file = fixture_file_upload('files/example_data.csv', 'text/csv')
        post :upload, { csvfile: csv_file }
        expect(response.status).to be(200)
      end

      it "should allow posting cvs files and load the data" do
        expect(response).to render_template("uploads/upload_result")
        expect(Purchaser.first.name).to eq("Snake Plissken")
        expect(Item.first.price.to_f).to eq(10.0)
        expect(Merchant.first.name).to eq("Bob's Pizza")
      end

      it "should post the current purchase total" do
        html_doc = Nokogiri::HTML(response.body)
        expect(html_doc.xpath("//div[@class=\"price-total\"]").text.strip).to eq("Final Balance: $95.00")
        expect(html_doc.xpath("//div[@class=\"price-grand-total\"]").text.strip).to eq("Grand Total to Date: $95.00")
      end
    end

    context "With an invalid csv file" do
      before do
        csv_file = fixture_file_upload('files/bad_example_data.csv', 'text/csv')
        post :upload, { csvfile: csv_file }
        expect(response.status).to be(200)
        @html_doc = Nokogiri::HTML(response.body)
      end

      it "should not charge a balance" do
        expect(@html_doc.xpath("//div[@class=\"status\"]").text.include?("Failure")).to eq(true)
        expect(@html_doc.xpath("//div[@class=\"price-total\"]").text.strip).to eq("Final Balance: $0.00")
        expect(@html_doc.xpath("//div[@class=\"price-grand-total\"]").text.strip).to eq("Grand Total to Date: $0.00")
      end

      it "should leave the database untouched" do
        expect(Purchaser.all.count).to eq(0)
        expect(Item.all.count).to eq(0)
        expect(Merchant.all.count).to eq(0)
      end
    end
  end

  describe "uploads#overview" do
    it "should provide an overview with 5 tables" do
      get :overview
      expect(response.status).to be(200)
      html_doc = Nokogiri::HTML(response.body)
      expect(html_doc.xpath("//h3").text.include?("Database Normalization Overview")).to eq(true)
      expect(html_doc.xpath("//table[@class=\"table-fill\"]").count).to eq(5)
    end
  end

end

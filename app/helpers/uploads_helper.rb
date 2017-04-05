module UploadsHelper
  def make_table(table_items = {})
  table = ""

  table += "<table class=\"table-fill\">
      <caption><h3>#{ table_items.count > 0 ? table_items.first.class.to_s.pluralize : "Empty Table" }<h3></caption>
      <thead>
        <tr>"
        if table_items.count > 0
          table_items.first.attributes.keys.each do |key|
            table += "<th>#{ key }</th>"
          end
        end
        table += "</tr>
      </thead>
      <tbody class=\"table-hover\">"
      table_items.each do |table_item|
        table += "<tr>"
        if table_items.count > 0
          table_item.attributes.values.each do |value|
            table += "<td class=\"text-left\">#{ value.is_a?(ActiveSupport::TimeWithZone) ? value.year.to_s +
                "/" + value.month.to_s + "/" + value.day.to_s + " " + value.hour.to_s + ":" + value.min.to_s + ":" + value.sec.to_s  : value }</td>"
          end
        end
        table += "</tr>"
      end
      table += "</tbody>
    </table>"
    table.html_safe
  end

  #TODO actually read this in
  def original_csv
    "<h3>Original CSV File Contents</h3>
     <table>
      <thead>
        <th>purchaser name</th>
        <th>item description</th>
        <th>item price</th>
        <th>purchase count</th>
        <th>merchant address</th>
        <th>merchant name</th>
      </thead>
      <tbody>
        <tr><td>Snake Plissken</td><td>$10 off $20 of food</td><td>10.0</td><td>2</td><td>987  Fake St</td><td>Bob's Pizza</td></tr>
        <tr><td>Amy Pond</td><td>$30 of awesome for $10</td><td>10.0</td><td>5</td><td>456 Unreal Rd</td><td>Tom's Awesome Shop</td></tr>
        <tr><td>Marty McFly</td><td>$20 Sneakers for $5</td><td>5.0</td><td>1</td><td>123 Fake St</td><td>Sneaker Store Emporium</td></tr>
        <tr><td>Snake Plissken</td><td>$20 Sneakers for $5</td><td>5.0</td><td>4</td><td>123 Fake St</td><td>Sneaker Store Emporium</td></tr>
      </tbody>
    </table>".html_safe
  end
end

REFACTOR

Try to have the views ONLY display HTML, the rest abstract away into a partial

<%= vehicle_builder.fields_for :dealership_vehicles, @dealership.dealership_vehicles.build do |dealership_vehicle_builder| %><br>
<%= dealership_vehicle_builder.label :is_lot_ready %><br>
<%= dealership_vehicle_builder.text_field :is_lot_ready %><br>
<%= dealership_vehicle_builder.label :buyer %><br>
<%= dealership_vehicle_builder.text_field :buyer %><br>
<%= dealership_vehicle_builder.label :price %><br>
<%= dealership_vehicle_builder.text_field :price %><br>
<%end%>
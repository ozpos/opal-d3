require "opal"
require "opal-d3"
require "data/iphones"

svg = D3.select("#visualization")
        .append("svg")
        .attr("height", "500px")
        .attr("width", "100%")
width = svg.style("width").to_i

x = D3.scale_linear.domain(IPhoneVariants.map(&:released).minmax).range([20,width-90]).nice
y = D3.scale_log.domain(IPhoneVariants.map(&:size).minmax).range([380,20])
c = D3.scale_ordinal.range(D3.scheme_category_10)

graph_area = svg.append("g")
    .attr("transform", "translate(60, 20)")
graph_area.select_all("circle")
  .data(IPhoneVariants).enter
  .append("circle")
    .attr("cx"){|d| x.(d.released)}
    .attr("cy"){|d| y.(d.size)}
    .attr("r", 10)
    .attr("fill"){|d| c.(d.name)}

axis_bottom = D3.axis_bottom(x)
  .tick_format(D3.time_format("%Y-%m-%d"))
axis_left = D3.axis_left(y)
  .tick_values([4,8,16,32,64,128,256])
  .tick_format{|v| "#{v} GB"}
graph_area.call(axis_left)
graph_area.append("g").attr("transform", "translate(0, 400)").call(axis_bottom)

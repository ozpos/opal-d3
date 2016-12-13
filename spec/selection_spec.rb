describe "d3 - selection" do
  after(:each) do
    D3.select("#test-area").html("")
  end

  it "d3.selection" do
    s = D3.selection
    expect(s).to be_instance_of(D3::Selection)
    expect(s.size).to eq(1)
  end

  it "d3.select" do
    s = D3.select("div")
    expect(s).to be_instance_of(D3::Selection)
    expect(s.size).to eq(1)
    expect(s.empty?).to eq(false)

    s = D3.select("h6")
    expect(s).to be_instance_of(D3::Selection)
    expect(s.size).to eq(0)
    expect(s.empty?).to eq(true)
  end

  it "d3.select_all" do
    s = D3.select_all("div")
    expect(s).to be_instance_of(D3::Selection)
    expect(s.size).to eq(1)
    expect(s.empty?).to eq(false)

    s = D3.select_all("h6")
    expect(s).to be_instance_of(D3::Selection)
    expect(s.size).to eq(0)
    expect(s.empty?).to eq(true)
  end

  it "selection.append" do
    div = D3.select_all("div")
    ul = div.append("ul")
    ul.append("li")
    ul.append("li")
    expect(div.html).to eq("<ul><li></li><li></li></ul>")
    ul.select_all("li").text = "WOW"
    expect(div.html).to eq("<ul><li>WOW</li><li>WOW</li></ul>")
  end

  it "selection.html / selection.text" do
    div = D3.select_all("div")
    expect(div.html).to eq("")
    expect(div.text).to eq("")

    div.html = "<h1>Hello, World!</h1>"
    expect(div.html).to eq("<h1>Hello, World!</h1>")
    expect(div.text).to eq("Hello, World!")

    h1 = div.select("h1")
    expect(h1.text).to eq("Hello, World!")
    h1.text = "Goodbye, World!"
    expect(div.html).to eq("<h1>Goodbye, World!</h1>")
    expect(div.text).to eq("Goodbye, World!")
    expect(h1.html).to eq("Goodbye, World!")
    expect(h1.text).to eq("Goodbye, World!")
  end

  it "selection.attr / selection.style" do
    d = D3.select_all("div")
    d.append("p").attr("class", "big").style("color", "red")
    expect(d.html).to eq(%Q[<p class="big" style="color: red;"></p>])

    p = d.select_all("p")
    expect(p.attr("class")).to eq("big")
    expect(p.style("color")).to eq("rgb(255, 0, 0)")
  end

  it "svg" do
    D3.select("div")
      .append("svg")
        .attr("width", 960)
        .attr("height", 500)
      .append("g")
        .attr("transform", "translate(20,20)")
      .append("rect")
        .attr("width", 920)
        .attr("height", 460)
    expect(D3.select("div").html).to eq(
      %Q[<svg width="960" height="500"><g transform="translate(20,20)"><rect width="920" height="460"></rect></g></svg>])
  end
end

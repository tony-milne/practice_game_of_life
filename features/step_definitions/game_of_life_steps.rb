Given /^the following setup$/ do |table|
  # table is a Cucumber::Ast::Table
  data = table.raw
  @l = Life.new(data)
end

When /^I evolve the board$/ do
  @l.tick
end

Then /^the center cell should be dead$/ do
  g = @l.grid
  g[1][1].state.should == "."
end

Then /^the center cell should be alive$/ do
  g = @l.grid
  g[1][1].state.should == "x"
end

Then /^I should see the following board$/ do |table|
  # table is a Cucumber::Ast::Table
  test_grid = table.raw
  grid = @l.get_grid
  test_grid.should == grid
end


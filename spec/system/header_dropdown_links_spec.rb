# frozen_string_literal: true

RSpec.describe "Header Dropdown Links", type: :system do
  let!(:theme) { upload_theme_component }

  it "displays header links correctly with basic configuration" do
    theme.update_setting(
      :header_links,
      [{ title: "Basic Link", url: "https://example.com", dropdown_links: [] }],
    )
    theme.save!

    visit("/")

    expect(page).to have_css(".header-links")
    expect(page).to have_css(".header-links__item a span", text: "Basic Link")
    expect(page).to have_no_css(".header-links__item .d-icon-angle-down")
    expect(page).to have_link("Basic Link", href: "https://example.com")
  end

  context "when header links have dropdown links" do
    it "displays dropdown with multiple links" do
      theme.update_setting(
        :header_links,
        [
          {
            title: "Tools",
            url: "https://example.com/tools",
            dropdown_links: [
              {
                title: "Calculator",
                url: "https://example.com/calculator",
                description: "Math calculations",
              },
              {
                title: "Designer",
                url: "https://example.com/designer",
                description: "Design tools",
              },
            ],
          },
        ],
      )
      theme.save!

      visit("/")

      expect(page).to have_css(".header-links")
      expect(page).to have_css(".header-links__item a span", text: "Tools")
      expect(page).to have_css(".header-links__item .d-icon-angle-down")

      page.find(".header-links__item", text: "Tools").hover

      expect(page).to have_css(".header-links__item-dropdown", visible: true)
      expect(page).to have_css(".header-links__item-dropdown a span", text: "Calculator")
      expect(page).to have_css(".header-links__item-dropdown a span", text: "Designer")
      expect(page).to have_css(".header-links__item-dropdown a span", text: "Math calculations")
      expect(page).to have_css(".header-links__item-dropdown a span", text: "Design tools")
      expect(page).to have_link("Calculator", href: "https://example.com/calculator")
      expect(page).to have_link("Designer", href: "https://example.com/designer")
    end

    it "displays dropdown link without description" do
      theme.update_setting(
        :header_links,
        [
          {
            title: "Resources",
            url: "https://example.com/resources",
            dropdown_links: [
              { title: "Documentation", url: "https://example.com/docs", description: "" },
            ],
          },
        ],
      )
      theme.save!

      visit("/")

      page.find(".header-links__item", text: "Resources").hover
      expect(page).to have_css(".header-links__item-dropdown a span", text: "Documentation")
    end

    it "ignores main link URL when dropdown links are present" do
      theme.update_setting(
        :header_links,
        [
          {
            title: "Menu",
            url: "https://example.com/should-be-ignored",
            dropdown_links: [
              { title: "Submenu Item", url: "https://example.com/submenu", description: "" },
            ],
          },
        ],
      )
      theme.save!

      visit("/")

      expect(page).to have_css(".header-links__item .d-icon-angle-down")
      page.find(".header-links__item", text: "Menu").hover
      expect(page).to have_css(".header-links__item-dropdown a span", text: "Submenu Item")
      expect(page).to have_link("Submenu Item", href: "https://example.com/submenu")
    end
  end

  context "when header links have empty dropdown_links array" do
    it "displays as regular link without dropdown" do
      theme.update_setting(
        :header_links,
        [{ title: "Simple Link", url: "https://example.com/simple", dropdown_links: [] }],
      )
      theme.save!

      visit("/")

      expect(page).to have_css(".header-links__item a span", text: "Simple Link")
      expect(page).to have_no_css(".header-links__item .d-icon-angle-down")
      expect(page).to have_link("Simple Link", href: "https://example.com/simple")
    end
  end

  it "displays multiple header links with mixed configurations" do
    theme.update_setting(
      :header_links,
      [
        { title: "Simple Link", url: "https://example.com/simple", dropdown_links: [] },
        {
          title: "Dropdown Link",
          url: "https://example.com/dropdown",
          dropdown_links: [
            { title: "Sub Item 1", url: "https://example.com/sub1", description: "First item" },
            { title: "Sub Item 2", url: "https://example.com/sub2", description: "" },
          ],
        },
      ],
    )
    theme.save!

    visit("/")

    expect(page).to have_css(".header-links")
    expect(page).to have_css(".header-links__item a span", text: "Simple Link")
    expect(page).to have_css(".header-links__item a span", text: "Dropdown Link")
    expect(page).to have_css(".header-links__item .d-icon-angle-down")

    page.find(".header-links__item", text: "Dropdown Link").hover
    expect(page).to have_css(".header-links__item-dropdown a span", text: "Sub Item 1")
    expect(page).to have_css(".header-links__item-dropdown a span", text: "Sub Item 2")
    expect(page).to have_link("Simple Link", href: "https://example.com/simple")
    expect(page).to have_link("Sub Item 1", href: "https://example.com/sub1")
  end
end

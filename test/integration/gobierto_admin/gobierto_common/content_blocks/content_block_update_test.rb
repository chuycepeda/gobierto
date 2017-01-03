require "test_helper"

module GobiertoAdmin
  module GobiertoCommon
    module ContentBlocks
      class ContentBlockUpdateTest < ActionDispatch::IntegrationTest
        def setup
          super
          @path = edit_admin_common_content_block_path(content_block)
        end

        def admin
          @admin ||= gobierto_admin_admins(:nick)
        end

        def site
          @site ||= sites(:madrid)
        end

        def content_block
          @content_block ||= gobierto_common_content_blocks(:contact_methods)
        end

        def test_content_block_update
          with_signed_in_admin(admin) do
            with_current_site(site) do
              visit @path

              within "form.edit_content_block" do
                within ".title_components" do
                  AVAILABLE_LOCALES.each do |locale|
                    fill_in locale, with: "Content block title in #{locale}"
                  end
                end

                content_block.fields.each do |content_block_field|
                  within ".content-block-field-record-#{content_block_field.id}" do
                    select "Currency", from: "Field type"

                    AVAILABLE_LOCALES.each do |locale|
                      fill_in locale, with: "Content block field in #{locale}"
                    end
                  end
                end

                click_button "Update Content block"
              end

              assert has_message?("Content block was successfully updated")

              within "form.edit_content_block" do
                within ".title_components" do
                  AVAILABLE_LOCALES.each do |locale|
                    assert has_field?(locale, with: "Content block title in #{locale}")
                  end
                end

                content_block.fields.each do |content_block_field|
                  within ".content-block-field-record-#{content_block_field.id}" do
                    assert has_select?("Field type", selected: "Currency")

                    AVAILABLE_LOCALES.each do |locale|
                      assert has_field?(locale, with: "Content block field in #{locale}")
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
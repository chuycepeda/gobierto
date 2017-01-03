require "test_helper"
require "support/integration/dynamic_content_helpers"

module GobiertoAdmin
  module GobiertoPeople
    class PersonCreateTest < ActionDispatch::IntegrationTest
      include Integration::DynamicContentHelpers

      def setup
        super
        @path = new_admin_people_person_path
      end

      def admin
        @admin ||= gobierto_admin_admins(:nick)
      end

      def site
        @site ||= sites(:madrid)
      end

      def content_context
        ::GobiertoPeople::Person.new
      end

      def test_person_create
        with_signed_in_admin(admin) do
          with_current_site(site) do
            visit @path

            within "form.new_person" do
              fill_in "person_name", with: "Person Name"
              fill_in "person_charge", with: "Person Charge"
              fill_in "person_bio", with: "Person Bio"
              fill_in "person_bio_url", with: "Person Bio URL"

              within ".person-visibility-level-radio-buttons" do
                choose "Active"
              end

              fill_in_content_blocks

              click_button "Create Person"
            end

            assert has_message?("Person was successfully created")
            assert has_selector?("h1", text: "Person Name")

            assert_content_blocks_have_the_right_values
          end
        end
      end
    end
  end
end
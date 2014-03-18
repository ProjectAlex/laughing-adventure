require 'spec_helper'

describe "Posts" do
    describe "GET /posts" do
        it "works! (now write some real specs)" do
            # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
            get posts_path
            response.status.should be(200)
        end
    end
    describe "Login page /users/sign_in" do
        it "Sign in page spec works" do
            get '/users/sign_in'
            response.status.should be(200)
        end
    end
    describe "Login page contents /users/sign_in" do
        it "Login page content present" do
            visit '/users/sign_in'
            expect(page).to have_content('A site by Prashant, Mithul, Mithun, Navnith')
        end
    end
    describe "Login page title" do
        it "Should have a title 'Alex|Login'" do
            visit "/users/sign_in"
            expect(page).to have_title('Alex | Login')
        end
    end
    describe "Register page /users/sign_up" do
        it "Sign up page spec works" do
            get '/users/sign_up'
            response.status.should be(200)
        end
    end
    describe "Register page contents /users/sign_in" do
        it "Register page content present" do
            visit '/users/sign_up'
            expect(page).to have_content('Sign up')
        end
    end
    describe "Signup page title" do
        it "Should have a title 'Alex|Sign Up'" do
            visit "/users/sign_up"
            expect(page).to have_title('Alex | Sign Up')
        end
    end
    describe "Root page" do
        it "root page works" do
            get '/'
            response.status.should be(200)
        end
    end
    describe "Root page content" do
        it "Testing contents on page" do
            visit root_path
            expect(page).to have_content('ALEX')
        end
    end
    describe "Home page title" do
        it "Should have a title 'Alex | Home'" do
            visit '/'
            expect(page).to have_title('Alex | Home')
        end
    end
end

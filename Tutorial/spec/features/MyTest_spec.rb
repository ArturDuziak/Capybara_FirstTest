require 'rails_helper'

feature 'Capybara tutorial', js: true do
    context 'Checks the login function' do

        correct_username = 'standard_user'
        correct_password = 'secret_sauce'
        
        scenario 'Logs in as a correct user and then logs out' do
            visit 'https://www.saucedemo.com/'

            fill_in('user-name', with: correct_username)
            fill_in('password', with: correct_password)

            click_on('LOGIN')

            expect(page).to have_current_path('/inventory.html')

            find(:xpath, '/html[1]/body[1]/div[1]/div[1]/div[1]/div[3]/div[1]').click
            click_on('logout_sidebar_link')

            expect(page).to have_current_path('/index.html')

        end

        def alert 
            find(:xpath, '//h3[1]').text
        end

        scenario 'Log in with incorrect password' do
            visit 'https://www.saucedemo.com/'

            fill_in('user-name', with: correct_username)
            fill_in('password', with: 'Wrongpassword')

            click_on('LOGIN')
            
            expect(alert).to include('Username and password do not match any user in this service')
        end

        scenario 'Log in with incorrect username' do
            visit 'https://www.saucedemo.com/'

            fill_in('user-name', with: 'random_username')
            fill_in('password', with: correct_password)

            click_on('LOGIN')
            
            expect(alert).to include('Username and password do not match any user in this service')
        end
        
        scenario 'Log in with incorrect password and login' do
            visit 'https://www.saucedemo.com/'

            fill_in('user-name', with: 'random_username')
            fill_in('password', with: 'randompassword')

            click_on('LOGIN')
            
            expect(alert).to include('Username and password do not match any user in this service')
        end
    end
end
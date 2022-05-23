*** Settings ***
Documentation    Login Test
Library  SeleniumLibrary

*** Variables ***
${BROWSER}  safari
${URL}  http://the-internet.herokuapp.com/login
${USERNAME}  tomsmith
${PASSWORD}  SuperSecretPassword!
${fault_user}  tomholland
${fault_password}  Password!
${Username_field}  //input[@id="username"]
${Password_field}  //input[@id="password"
${Login_btn}  //i[@class="fa fa-2x fa-sign-in"]
${Logout_btn}  //i[@class="icon-2x icon-signout"]

*** Test Cases ***
To verify that a user can login successfully when they put a correct username and password
    Given Open website
    When Input Username
    Then Input Password
    Then Validate Login Success Result

To verify that a user can login unsuccessfully when they put a correct username but wrong password
    Given Open website
    When Input Username
    Then Input Wrong Password
    Then Validate Login Failed Password Result

To verify that a user can login unsuccessfully when they put a username that did not exist.
    Given Open website
    When Input Wrong Username
    Then Input Password
    Then Validate Login Failed Username Result

*** Keywords ***
Open website
    Open browser  ${URL}  ${BROWSER}
    wait until page contains  Login Page
    maximize browser window

Input Username
    input text  //input[@id="username"]  ${USERNAME}

Input Wrong Username
    input text  //input[@id="username"]  ${fault_user}

Input Password
    wait until keyword succeeds  1 min  1 sec  input text  //input[@id="password"]  ${PASSWORD}

Input Wrong Password
    wait until keyword succeeds  1 min  1 sec  input text  //input[@id="password"]  ${fault_password}

Validate Login Success Result
    Click Element  ${Login_btn}
    wait until page contains  You logged into a secure area!
    sleep  2s
    Click Element  ${Logout_btn}
    wait until page contains  You logged out of the secure area!
    sleep  2s
    Close Browser

Validate Login Failed Password Result
    Click Element  ${Login_btn}
    wait until page contains  Your password is invalid!
    sleep  2s
    Close Browser

Validate Login Failed Username Result
    Click Element  ${Login_btn}
    wait until page contains  Your username is invalid!
    sleep  2s
    Close Browser

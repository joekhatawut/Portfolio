*** Settings ***
Library  Collections
Library  RequestsLibrary
Library    JSONLibrary



*** Variables ***
${BASE_URL}  https://reqres.in/

*** Test Cases ***
Get User Profile Success
    Create session    user_query  ${BASE_URL}
    ${response}=    GET On Session    user_query  api/users/12

    #Verify Status code
    ${status_code}=    convert to string    ${response.status_code}
    should be equal    ${status_code}    200

    ${json.response}    set variable    ${response.json()}

    #Verify ID
    ${id_data}=    get value from json    ${json.response}    data.id
    ${id_dataFromList}=    get from list    ${id_data}    0
    ${id_dataFromListAsString}=    Convert to String  ${id_dataFromList}
    should be equal    ${id_dataFromListAsString}    12

    #Verify Email
    ${email_data}=    get value from json    ${json.response}    data.email
    ${email_dataFromList}=    get from list    ${email_data}    0
    ${email_dataFromListAsString}=    Convert to String  ${email_dataFromList}
    should be equal    ${email_dataFromListAsString}    rachel.howell@reqres.in

    #Verify First Name
    ${fname_data}=    get value from json    ${json.response}    data.first_name
    ${fname_dataFromList}=    get from list    ${fname_data}    0
    ${fname_dataFromListAsString}=    Convert to String  ${fname_dataFromList}
    should be equal    ${fname_dataFromListAsString}    Rachel

    #Verify Last Name
    ${lname_data}=    get value from json    ${json.response}    data.last_name
    ${lname_dataFromList}=    get from list    ${lname_data}    0
    ${lname_dataFromListAsString}=    Convert to String  ${lname_dataFromList}
    should be equal    ${lname_dataFromListAsString}    Howell

    #Verify Avatar
    ${avatar_data}=    get value from json    ${json.response}    data.avatar
    ${avatar_dataFromList}=    get from list    ${avatar_data}    0
    ${avatar_dataFromListAsString}=    Convert to String  ${avatar_dataFromList}
    should be equal    ${avatar_dataFromListAsString}    https://reqres.in/img/faces/12-image.jpg

Get User Profile but user not found
    Create session    user_query  ${BASE_URL}
    ${response}=    GET On Session    user_query  api/users/1234    expected_status=404

    #Verify Status code
    ${status_code}=    convert to string    ${response.status_code}
    should be equal    ${status_code}    404

    #Verify Empty Response body
    ${json.response}    set variable    ${response.json()}
    ${blank_data}=    get value from json    ${json.response}   Any
    should be empty    ${blank_data}









*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***

${BASE_URL}         https://d2x000000qylfeam-dev-ed.my.salesforce.com
${ACCESS_TOKEN}     00D2x000000qYLf!AQEAQGdEFHFzviFnIQ_j_sFV5INc8TK6p3cvKofI5YCgDgp0Zf1mg4i7stKr3wDdj6_tP1psL8MhhICH0H7AW.uRQOsEEMdC

*** Test Cases ***
Lead CRUD Flow

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${ACCESS_TOKEN}
    ...    Content-Type=application/json

    Create Session    salesforce    ${BASE_URL}    headers=${headers}

# CREATE LEAD

    ${body}=    Create Dictionary
    ...    FirstName=CRT fix test
    ...    LastName=Level up
    ...    Company=CIT
    ...    Status=Open - Not Contacted

    ${response}=    POST On Session
    ...    salesforce
    ...    /services/data/v58.0/sobjects/Lead/
    ...    json=${body}

    Should Be Equal As Integers    ${response.status_code}    201

    ${LeadID}=    Set Variable    ${response.json()['id']}
    Log    Lead Created ${LeadID}

# GET LEAD

    ${getResponse}=    GET On Session
    ...    salesforce
    ...    /services/data/v58.0/sobjects/Lead/${LeadID}

    Should Be Equal As Integers    ${getResponse.status_code}    200

# UPDATE LEAD

    ${updateBody}=    Create Dictionary
    ...    Company= CQ Updated

    ${updateResponse}=    PATCH On Session
    ...    salesforce
    ...    /services/data/v58.0/sobjects/Lead/${LeadID}
    ...    json=${updateBody}

    Should Be Equal As Integers    ${updateResponse.status_code}    204

# DELETE LEAD

    ${deleteResponse}=    DELETE On Session
    ...    salesforce
    ...    /services/data/v58.0/sobjects/Lead/${LeadID}

    Should Be Equal As Integers    ${deleteResponse.status_code}    204

    Log    Lead Deleted Successfully
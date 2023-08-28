*** Settings ***
Resource    ../main.robot


*** Variables ***
&{home}
...         A_Signup=//a[@href="https://www.phptravels.net/signup"]
...         a_voos=//a[contains(text(),"flights")]
...         A_Visto=//a[@href="https://www.phptravels.net/visa"]


*** Keywords ***
Dado que acesso a página de visto
    Wait Until Element Is Visible    ${home.A_Visto}    10
    Click Element    ${home.A_Visto}

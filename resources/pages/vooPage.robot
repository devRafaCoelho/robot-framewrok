*** Settings ***
Resource    ../main.robot


*** Variables ***
&{voo}
...         Input_IdaeVolta=//input[@id="round-trip"]
...         Input_Ida=//input[@id="autocomplete"]
...         Input_Volta=//input[@id="autocomplete2"]
...         Input_DataIda=(//input[@id="departure"])[1]
...         Input_DataVolta=(//input[@id="return"])[1]
...         A_PassageirosDrop=//a[@href="#"]
...         Div_QtdPassageiros=(//div[@class="qtyInc"])[1]
...         Button_PesquisarVoo=//button[@id="flights-search"]


*** Keywords ***
Dado que eu realizo uma busca de um vôo ida e volta
    Wait Until Element Is Visible    ${home.a_voos}    10
    Click Element    ${home.a_voos}
    Wait Until Element Is Visible    ${voo.Input_IdaeVolta}    10
    Click Element    ${voo.Input_IdaeVolta}

E saindo de ${Texto}
    Wait Until Element Is Visible    ${voo.Input_Ida}    10
    Input Text    ${voo.Input_Ida}    ${Texto}
    Press Keys    ${voo.Input_Ida}    ARROW_DOWN
    Press Keys    ${voo.Input_Ida}    ENTER

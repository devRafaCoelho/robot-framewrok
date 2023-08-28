*** Settings ***
Resource    ../main.robot


*** Variables ***
&{visto}
...         Span_PaisOrigem=(//span[@class="select2-selection select2-selection--single"])[1]
...         Input_InformaPaisOrigem=//input[@aria-controls="select2-from_country-results"]


*** Keywords ***
E informo o pais de origem sendo o ${Texto}
    Wait Until Element Is Visible    ${visto.Span_PaisOrigem}    10
    Click Element    ${visto.Span_PaisOrigem}
    Wait Until Element Is Visible    ${visto.Input_InformaPaisOrigem}    10
    Input Text    ${visto.Input_InformaPaisOrigem}    ${Texto}
    Press Keys    ${visto.Input_InformaPaisOrigem}    ENTER

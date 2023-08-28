*** Settings ***
Resource    ../main.robot


*** Variables ***
&{registro}
...             Input_PrimeiroNome=//input[@placeholder="First Name"]
...             Input_UltimoNome=//input[@placeholder="Last Name"]
...             Input_Telefone=//input[@placeholder="Phone"]
...             Input_Email=//input[@placeholder="Email"]
...             Input_Senha=//input[@placeholder="Password"]
...             Button_Signup= //button[@class="btn btn-default btn-lg btn-block effect ladda-button waves-effect"]
...             Button_Cookie=//button[@id="cookie_stop"]

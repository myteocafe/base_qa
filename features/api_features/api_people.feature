@api
Feature: [BE] Obtenemos el listado de las personas matriculadas en el mock

  Scenario: Se listan las personas matriculadas
    Given Existen personas en el listado
    When se solicita al sistema el listado
    Then the response status should be 200
    And el sistema retorna la información solicitada


  Scenario: Se solicita detalle de personas disponibles
    Given El usuario "Zulema Santacruz" es un usuario registrado
    When se solicita al sistema el detalle del usuario
    Then the response status should be 200
    And el sistema retorna el detalle del usuario solicitado


  Scenario Outline: Se solicita detalle de cada persona disponible
    Given El usuario "<user_name>" es un usuario registrado
    When se solicita al sistema el detalle del usuario
    Then the response status should be 200
    And el sistema retorna el detalle del usuario solicitado
    Examples:
      | user_name        |
      | Zulema Santacruz |
      | Kei Takayama     |
      | Misael Castillo  |


  Scenario Outline: Se solicita detalle de cada persona disponible y se valida el monto de la deuda
    Given El usuario "<user_name>" es un usuario registrado
    When se solicita al sistema el detalle del usuario
    Then the response status should be 200
    And el sistema retorna el detalle del usuario solicitado
    And el monto de deuda es "<debt>"
    Examples:
      | user_name        |debt|
      | Zulema Santacruz |5000.45|
      | Kei Takayama     |3500.22|
      | Misael Castillo  |5000.00|
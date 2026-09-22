CLASS zcl_http_carga_libros_vfu DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_http_carga_libros_vfu IMPLEMENTATION.
  METHOD if_http_service_extension~handle_request.
    DATA: lt_libros TYPE TABLE OF ztb_libros_vfuen.

    CASE request->get_method( ).
      WHEN 'POST'.
        " Cargar datos recibidos en JSON a la tabla
        DATA(lv_body) = request->get_text( ).
        xco_cp_json=>data->from_string( lv_body )->write_to( REF #( lt_libros ) ).

        IF lt_libros IS NOT INITIAL.
          INSERT ztb_libros_vfuen FROM TABLE @lt_libros ACCEPTING DUPLICATE KEYS.
          response->set_status( 201 ).
          response->set_text( 'Datos cargados correctamente' ).
        ELSE.
          response->set_status( 400 ).
          response->set_text( 'Estructura JSON inválida o vacía' ).
        ENDIF.

      WHEN 'GET'.
        response->set_text( 'Servicio HTTP Activo para carga de Libros' ).
    ENDCASE.
  ENDMETHOD.
ENDCLASS.

with estado select
    semaforo <= "rojo" when "01",
                "verde" when "10",
                "amarillo" when "11",
                "no funciona" when OTHERS;

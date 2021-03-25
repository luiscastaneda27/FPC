public class ConvertirNumeros {

    public static Integer flag = 0;
    public static String importe_parcial = null;
    public static String num = null;
    public static String num_letra = null;
    public static String num_letras = null;
    public static String num_letram = null;
    public static String num_letradm = null;
    public static String num_letracm = null;
    public static String num_letramm = null;
    public static String num_letradmm = null;
    
    private static String unidad(Integer numero){
        
        if (numero == 9) num = 'nueve';
        if (numero == 8) num = 'ocho';
        if (numero == 7) num = 'siete';
        if (numero == 6) num = 'seis';
        if (numero == 5) num = 'cinco';
        if (numero == 4) num = 'cuatro';
        if (numero == 3) num = 'tres';
        if (numero == 2) num = 'dos';
        if (numero == 1) {
           if (flag == 0)
              num = 'uno';
           else 
              num = 'un';
        }
        
        if (numero == 0) num = '';
        
        return num;
    }
    
    private static String decena(Integer numero){
    
        flag = 0;
        
        if (numero >= 90 && numero <= 99)
        {
            num_letra = 'noventa ';
            if (numero > 90)
                num_letra = num_letra + 'y ' + (unidad(numero - 90));
        }
        else if (numero >= 80 && numero <= 89)
        {
            num_letra = 'ochenta ';
            if (numero > 80)
                num_letra = num_letra + 'y ' + (unidad(numero - 80));
        }
        else if (numero >= 70 && numero <= 79)
        {
            num_letra = 'setenta ';
            if (numero > 70)
                num_letra = num_letra + 'y ' +(unidad(numero - 70));
        }
        else if (numero >= 60 && numero <= 69)
        {
            num_letra = 'sesenta ';
            if (numero > 60)
                num_letra = num_letra + 'y ' + (unidad(numero - 60));
        }
        else if (numero >= 50 && numero <= 59)
        {
            num_letra = 'cincuenta ';
            if (numero > 50)
                num_letra = num_letra+ 'y ' + (unidad(numero - 50));
        }
        else if (numero >= 40 && numero <= 49)
        {
            num_letra = 'cuarenta ';
            if (numero > 40)
                num_letra = num_letra + 'y ' + (unidad(numero - 40));
        }
        else if (numero >= 30 && numero <= 39)
        {
            num_letra = 'treinta ';
            if (numero > 30)
                num_letra = num_letra + 'y ' + (unidad(numero - 30));
        }
        else if (numero >= 20 && numero <= 29)
        {
            if (numero == 20)
                num_letra = 'veinte ';
            else
                num_letra = 'veinte y ' + (unidad(numero - 20));
        }
        else if (numero >= 10 && numero <= 19)
        {
            if (numero == 10) num_letra = 'diez';
            if (numero == 11) num_letra = 'once';
            if (numero == 12) num_letra = 'doce';
            if (numero == 13) num_letra = 'trece';
            if (numero == 14) num_letra = 'catorce';
            if (numero == 15) num_letra = 'quince';
            if (numero == 16) num_letra = 'dieciseis';
            if (numero == 17) num_letra = 'diecisiete';
            if (numero == 18) num_letra = 'dieciocho';
            if (numero == 19) num_letra = 'diecinueve';
        }
        else
            num_letra = unidad(numero);

        return num_letra;
    }   

    private static String centena(Integer numero){
        if (numero >= 100)
        {
            if (numero >= 900 && numero <= 999)
            {
                num_letra = 'novecientos ';
                if (numero > 900)
                    num_letra = num_letra + (decena(numero - 900));
            }
            else if (numero >= 800 && numero <= 899)
            {
                num_letra = 'ochocientos ';
                if (numero > 800)
                    num_letra = num_letra + (decena(numero - 800));
            }
            else if (numero >= 700 && numero <= 799)
            {
                num_letra = 'setencientos ';
                if (numero > 700)
                    num_letra = num_letra + (decena(numero - 700));
            }
            else if (numero >= 600 && numero <= 699)
            {
                num_letra = 'seiscientos ';
                if (numero > 600)
                    num_letra = num_letra + (decena(numero - 600));
            }
            else if (numero >= 500 && numero <= 599)
            {
                num_letra = 'quinientos ';
                if (numero > 500)
                    num_letra = num_letra + (decena(numero - 500));
            }
            else if (numero >= 400 && numero <= 499)
            {
                num_letra = 'cuatrocientos ';
                if (numero > 400)
                    num_letra = num_letra + (decena(numero - 400));
            }
            else if (numero >= 300 && numero <= 399)
            {
                num_letra = 'trescientos ';
                if (numero > 300)
                    num_letra = num_letra + (decena(numero - 300));
            }
            else if (numero >= 200 && numero <= 299)
            {
                num_letra = 'doscientos ';
                if (numero > 200)
                    num_letra = num_letra + (decena(numero - 200));
            }
            else if (numero >= 100 && numero <= 199)
            {
                if (numero == 100)
                    num_letra = 'cien ';
                else
                    num_letra = 'ciento ' + (decena(numero - 100));
            }
        }
        else
            num_letra = decena(numero);
        
        return num_letra;   
    }   

    private static String miles(Integer numero){
        if (numero >= 1000 && numero <2000){
            num_letram = (' mil ') + (centena(Math.mod(numero,1000)));
        }
        if (numero >= 2000 && numero <10000){
            flag=1;
            num_letram = unidad(numero/1000) + (' mil ') + (centena(Math.mod(numero,1000)));
        }
        if (numero < 1000)
            num_letram = centena(numero);
        
        return num_letram;
    }       

    private static String decmiles(Integer numero){
        if (numero == 10000)
            num_letradm = 'diez mil';
        if (numero > 10000 && numero <20000){
            flag=1;
            num_letradm = decena(numero/1000) + (' mil ') + (centena(Math.mod(numero,1000)));        
        }
        if (numero >= 20000 && numero <100000){
            flag=1;
            num_letradm = decena(numero/1000) + (' mil ') + (miles(Math.mod(numero,1000)));     
        }

        if (numero < 10000)
            num_letradm = miles(numero);
        
        return num_letradm;
    }       

    private static String cienmiles(Integer numero){
        if (numero == 100000)
            num_letracm = 'cien mil';
        if (numero >= 100000 && numero <1000000){
            flag=1;
            num_letracm = centena(numero/1000)+ (' mil ')+(centena(Math.mod(numero,1000)));     
        }
        if (numero < 100000)
            num_letracm = decmiles(numero);
        return num_letracm;
    }       

    private static String millon(Integer numero){
        if (numero >= 1000000 && numero <2000000){
            flag=1;
            num_letramm = ('un millon ') + (cienmiles(Math.mod(numero,1000000)));
        }
        if (numero >= 2000000 && numero <10000000){
            flag=1;
            num_letramm = unidad(numero/1000000)+(' millones ')+(cienmiles(Math.mod(numero,1000000)));
        }
        if (numero < 1000000)
            num_letramm = cienmiles(numero);
        
        return num_letramm;
    }       
    
    private static String decmillon(Integer numero){
        if (numero == 10000000)
            num_letradmm = 'diez millones';
        if (numero > 10000000 && numero <20000000){
            flag=1;
            num_letradmm = decena(numero/1000000)+(' millones ')+(cienmiles(Math.mod(numero,1000000)));      
        }
        if (numero >= 20000000 && numero <100000000){
            flag=1;
            num_letradmm = decena(numero/1000000)+(' milllones ')+(millon(Math.mod(numero,1000000)));       
        }
        
        
        if (numero < 10000000)
            num_letradmm = millon(numero);
        
        return num_letradmm;
    }       

    public static String convertirLetras(Integer numero){
        flag = 0;
        if (numero == null)
           num_letras = 'nulo';
        else
           num_letras = decmillon(numero);
        return num_letras;
    }
}
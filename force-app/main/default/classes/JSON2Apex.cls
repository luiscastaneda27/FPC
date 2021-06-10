public class JSON2Apex {
    public String PC_MEDIDA_APLICADA;
    public String PC_NIVEL_RIESGO;
    
    
    public static List<JSON2Apex> parse(String json) {
        return (List<JSON2Apex>) System.JSON.deserialize(json, List<JSON2Apex>.class);
         
    }
}
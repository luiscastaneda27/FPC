public class ControllerBitacoraConciliacion {
    
    public date fecdesde{get;set;}
    public date FecHasta{get;set;} 
    
    public Bitacora_Conciliacion__c accion {get;set;}
    public list<Bitacora_Conciliacion__c> listacciones{get;set;}
    public list<Bitacora_Conciliacion__c> LIstBitaPrueba{get;set;}
    public boolean mostrartabla{get;set;}
    public string usuario{get;set;}
    public string pagina{get;set;}
    
    //
    public list<Bitacora_Conciliacion__c> ListaEnviarSYSDE{get;set;}
    
    public ControllerBitacoraConciliacion()
    {
        
        accion = new Bitacora_Conciliacion__c();
        mostrartabla=false;
        Usuario =  ApexPages.currentPage().getParameters().get('hytrd');
        //usuario = ApexPages.currentPage().getParameters().get('hytrd');
        LIstBitaPrueba = [ select Fecha__c, Usuario__c,Actividades__c, Pantalla__c, Evento__c 
            			 from Bitacora_Conciliacion__c];
        
    }
    
    public void ListaVF()
    {
        pagina = 'VFPDFBitacoraConciliacion';
    }
    
    public void bitacora()
    {
        //Insertar en la bitacora
                  Bitacora_Conciliacion__c bita = new Bitacora_Conciliacion__c ();
                  bita.Actividades__c = 'Se genero una bitacora';
                  bita.Fecha__c = date.today();
                  bita.Pantalla__c = 'VFBitacoraConciliacion';
                  bita.Evento__c = 'Consulta';
                  bita.Usuario__c = Usuario;
                  insert bita;
           
    }   
    

    public void Generar()
    {
        try
        {
            
        mostrartabla=false;
        string query = 'select Fecha__c, Usuario__c,Actividades__c, Pantalla__c, Evento__c from Bitacora_Conciliacion__c where Fecha__c >= :fecdesde  and Fecha__c <= :FecHasta ';
       
       
        query +=' order by fecha__C desc';
        listacciones =new list<Bitacora_Conciliacion__c> ();
        list<Bitacora_Conciliacion__c> listacciones1= new list<Bitacora_Conciliacion__c>();
        system.debug(query);
        listacciones1 = database.query(query);
         
        if(fecdesde == null  || fechasta == null)
        {
            //listacciones=listacciones1;
             
        }
         else
         {
             for(integer i=0; i<listacciones1.size(); i++)
            {
                date fecha;
                
                if(listacciones1[i].fecha__C.month()<10)
                {
                     fecha =date.valueOf(listacciones1[i].fecha__C.year()+'-0'+listacciones1[i].fecha__C.month()+'-'+listacciones1[i].fecha__C.day());
                }
                else
                {
					 fecha =date.valueOf(listacciones1[i].fecha__C.year()+'-'+listacciones1[i].fecha__C.month()+'-'+listacciones1[i].fecha__C.day());                    
                }
                
                system.debug(fecha);
                system.debug(fecdesde);
                
                if(fecha >= fecdesde && fecha <=fechasta )
                {
                    listacciones.add(listacciones1[i]);
                }
                
            }
             
         }
         if(listacciones.size()>0 )
            {
                mostrartabla=true;
                bitacora();
            }
            else
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No se encontraron resultados.')); 
            }
           
        }
        catch (Exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ha ocurrido un error'+ex.getCause()+ex.getMessage())); 
        }        
        
    }

    
    public void ocultarTabla()
    {
        mostrartabla = false;
    }
    
    public  List<BitacoraConciliacion> ListaCargaC {get;set;}
    
    public void EnviarListasysde()
    {
        ListaEnviarSYSDE = [ select Fecha__c, Usuario__c,Actividades__c, Pantalla__c, Evento__c 
                             from Bitacora_Conciliacion__c limit 2000];
        
        system.debug('ListaSYSDEENVIAR' + ListaEnviarSYSDE);
        
        ListaCargaC = new list<BitacoraConciliacion>();
        
       for(integer i=0; i<ListaEnviarSYSDE.size(); i++)
       {
           
            ListaCargaC.add(new BitacoraConciliacion ( DATE.valueOf(ListaEnviarSYSDE[i].Fecha__c),
                                                          ListaEnviarSYSDE[i].Usuario__c,
                                                          ListaEnviarSYSDE[i].Actividades__c,
                                                          ListaEnviarSYSDE[i].Pantalla__c,
                                                          ListaEnviarSYSDE[i].Evento__c
           												));            
        }
        
        //EnviarLista A SYSDE CADA DOMINGO PARA QUE NO GUARDE EN SF SOLO EN LA BD:
        
        ControllerAPICONCILIACION.ListaBitaaa respuesta = new ControllerAPICONCILIACION.ListaBitaaa ();
        
        ControllerAPICONCILIACION.ListaBitaaa loa = new ControllerAPICONCILIACION.ListaBitaaa ();
        loa.ListaCargaC1 = ListaCargaC;
        System.debug('ListaBita' + ListaCargaC);
        
        ControllerAPICONCILIACION.GuardarEnBitacoraSYSDE(loa); 
  
    }
    
    
    
   public class BitacoraConciliacion {

     public date   FechaValor{get;set;} 
     public string Actividades{get;set;} 
     public string Evento{get;set;} 
     public string Pantalla{get;set;} 
     public string Usuario{get;set;}   

     public BitacoraConciliacion(date FechaValor, string Actividades, string Evento, string Pantalla, string Usuario)
    {
        this.FechaValor= FechaValor;
        this.Actividades=Actividades;
        this.Evento=Evento;
        this.Pantalla=Pantalla;
        this.Usuario=Usuario;
    }

    
    
} 
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
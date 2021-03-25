public with sharing class getSaldoCuenta {
	public string cuenta { get; Set; }
    public string saldoTotal { get; set; }
    public string montoPignorado { get; set; }
    public list<classSaldos> saldos { get; set; }
}
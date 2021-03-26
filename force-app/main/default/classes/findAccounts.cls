public class findAccounts {
	private final List<Account> accounts;

	public findAccounts() {
		accounts = [select Name from Account where Id = '0015400000V4eToAAJ'];
	}

	public List<Account> getAccounts() {
		return accounts;
	}
}
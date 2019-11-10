# unwrap-wrapped-plsql
Using PERL to unwrap wrapped PLSQL code

Software required:
Download and install Padre, the Perl IDE/editor (Strawberry Perl version 5.12.3 comes as part of the install, you also get many other useful CPAN modules as well).
Download and install DBIx-Oracle-Unwrap-0.06. [License information]
Download and install DBI
Download and install DBD-Oracle

1. Install Padre Perl IDE as per the instructions given in the Perl website.

2. You can use Padre IDE to install DBIx-Oracle-Unwrap-0.06, DBI and DBD-Oracle Perl modules. Example: Go to Tools->Module Tools->Install Local Distribution and select DBIx-Oracle-Unwrap-0.06.tar.gz file.

3. If the wrapped file is in the local machine, then use unwrap.pl. Open the unwrap.pl in Padre IDE and point the file location. Example: “D:\\SQL\\pks_accrual_wrapper.sql.plb”.

Open a command prompt and do the following:

    C:\> perl unwrap.pl > pks_accrual_wrapper.sql

    unwrap.pl code

    use DBIx::Oracle::Unwrap;
    my $filename = “D:\\SQL\\pks_accrual_wrapper.sql.plb”;
    my $unwrapper = DBIx::Oracle::Unwrap->new();
    my $unwrapped_text = $unwrapper->unwrap_file($filename);
    print $unwrapped_text;

Note:
unwrap.pl: Perl script that unwrap the wrapped PLSQL code.
pks_accrual_wrapper.sql.plb: wrapped PLSQL code.
pks_accrual_wrapper.sql: unwrapped code after Perl script execution.

4. If the wrapped code is in the database and you want to get the unwrapped version downloaded into your machine then use unwrap_db.pl. Rest of the process is same as shown above. Example: labopdev schema has pks_csdermsg_main package whose body is wrapped. Using unwrap_db.pl, pks_csdermsg_main_unwrapped.sql is created.

Open a command prompt and do the following:

    C:\> perl unwrap_db.pl > pks_csdermsg_main_unwrapped.sql

    unwrap_db.pl code

    use DBIx::Oracle::Unwrap;
    use DBI;
    my $dbh = DBI->connect(‘DBI:Oracle:la11g’, ‘LABOPDEV’, ‘LABOPDEV’);
    my $source_sql = q/
    SELECT text
    FROM user_source
    WHERE name = ‘PKS_CSDERMSG_MAIN’
    AND type = ‘PACKAGE BODY’
    ORDER BY line
    /;
    my $source = join(“”,@{$dbh->selectcol_arrayref($source_sql)});
    my $unwrapper = DBIx::Oracle::Unwrap->new();
    my $unwrapped_text = $unwrapper->unwrap($source);
    print $unwrapped_text;

Note:
unwrap_db.pl: Perl script that unwrap the wrapped PLSQL code.
PKS_CSDERMSG_MAIN: The name of the package in schema LABOPDEV of database LABOPDEV.
pks_csdermsg_main_unwrapped.sql: unwrapped PLSQL code.

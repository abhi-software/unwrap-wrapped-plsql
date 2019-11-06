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
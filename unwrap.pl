use DBIx::Oracle::Unwrap;
my $filename = “D:\\SQL\\pks_accrual_wrapper.sql.plb”;
my $unwrapper = DBIx::Oracle::Unwrap->new();
my $unwrapped_text = $unwrapper->unwrap_file($filename);
print $unwrapped_text;
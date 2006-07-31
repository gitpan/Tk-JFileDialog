use ExtUtils::MakeMaker;
WriteMakefile(
		NAME => 'Tk::JFileDialog',
		VERSION_FROM => 'Tk/JFileDialog.pm',
		PM => { 'Tk/JFileDialog.pm' => '$(INST_LIBDIR)/JFileDialog.pm',
			'Tk/JBrowseEntry.pm' => '$(INST_LIBDIR)/JBrowseEntry.pm' },
		EXE_FILES => ['JFileDialogTest.pl'],
		'dist' => { COMPRESS=>'gzip -9f', SUFFIX => 'gz' },
);

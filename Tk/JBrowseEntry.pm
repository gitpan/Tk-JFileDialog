#
# JBrowseEntry is a stripped down version of ComboBox.tcl from Tix4.0

=head1 NAME

JBrowseEntry is a full-featured "Combo-box" (Text-entry combined with drop-down 
listbox.

=head1 DESCRIPTION

JBrowseEntry widgets allow one to specify a full combo-box, a "readonly" 
box (text field allows user to type the 1st letter of an item to search for, 
but user may only ultimately select one of the items in the list), or a 
"textonly" version (drop-down list disabled), or a completely disabled 
widget.  

This widget is similar to other combo-boxes, ie. 	JComboBox, but has good 
keyboard bindings and allows for quick lookup/search within the listbox. 
pressing <RETURN> in entry field displays the dropdown box with the 
first entry most closly matching whatever's in the entry field highlighted. 
Pressing <RETURN> or <SPACE> in the listbox 
selects the highlighted entry and copies it to the text field and removes the 
listbox.  <ESC> removes the listbox from view.  
<UP> and <DOWN> arrows work the listbox as well as pressing a key, which will 
move the highlight to the next item starting with that letter/number, etc. 
<UP> and <DOWN> arrows pressed within the entry field circle through the 
various list options as well (unless "-state" is set to 'textonly').  
Set "-state" to "text" to disable the dropdown list, but allow <UP> and 
<DOWN> to cycle among the choices.  Setting "-state" to 'textonly' completely 
hides the choices list from the user - he must type in his choice just like 
a normal entry widget.

One may also specify whether or not the button which activates the 
dropdown list via the mouse can take focus or not (-btntakesfocus) or 
whether the widget itself can take focus or is skipped in the focusing 
order.  The developer can also specify alternate bitmap images for the 
button (-arrowimage and -farrowimage).  The developer can also specify the 
maximum length of the dropdown list such that if more than that number of 
items is added, a vertical scrollbar is automatically added (-height).  
A fixed width in characters (-width) can be specified, or the widget can be 
allowed to resize itself to the width of the longest string in the list.  The 
listbox and text entry field are automatically kept to the same width.

One can optionally specify a label (-label), similar to the "LabEntry" widget.  
By default, the label appears packed to the left of the widget.  The 
positioning can be specified via the "-labelPack" option.  For example, to 
position the label above the widget, use "-labelPack => [-side => 'top']".

=head1 EXAMPLES

 It is easiest to illustrate this widget's capabilities via examples:
 
 use Tk;
 use Tk::JBrowseEntry;
 
 $MainWin = MainWindow->new;
 
 #SET UP SOME DEFAULT VALUES.
 
 $dbname1 = 'cows';
 $dbname2 = 'foxes';
 $dbname3 = 'goats';
 $dbname5 = 'default';
 
 #HERE'S A NORMAL COMBO-BOX.
 
 $jb1 = $MainWin->JBrowseEntry(
 	-label => 'Normal:',
 	-variable => \$dbname1,
 	-state => 'normal',
 	-choices => [qw(pigs cows foxes goats)],
 	-width  => 12);
 $jb1->pack(
 	-side   => 'top', -pady => '10', -anchor => 'w');
 
 #THIS ONE HAS THE DROPDOWN LIST DISABLED.
 
 $jb2 = $MainWin->JBrowseEntry(
 	-label => 'TextOnly:',
 	-variable => \$dbname2,
 	-state => 'text',
 	-choices => [qw(pigs cows foxes goats)],
 	-width  => 12);
 $jb2->pack(
 	-side   => 'top', -pady => '10', -anchor => 'w');
 
 #THIS ONE'S "READONLY" (USER MUST PICK FROM THE LIST, TEXT BOX ALLOWS QUICK 
 #SEARCH.
 
 $jb3 = $MainWin->JBrowseEntry(
 	-label => 'ReadOnly:',
 	-variable => \$dbname3,
 	-choices => [qw(pigs cows foxes goats)],
 	-state => 'readonly',
 	-width  => 12);
 $jb3->pack(
 	-side   => 'top', -pady => '10', -anchor => 'w');
 
 #THIS ONE'S COMPLETELY DISABLED!
 
 $jb4 = $MainWin->JBrowseEntry(
 	-label => 'Disabled:',
 	-variable => \$dbname3,
 	-state => 'disabled',
 	-choices => [qw(pigs cows foxes goats)],
 	-width  => 12);
 $jb4->pack(
 	-side   => 'top', -pady => '10', -anchor => 'w');
 
 #HERE'S ONE WITH A SCROLLBAR (NOTE THE "-height" ATTRIBUTE).
 
 $jb5 = $MainWin->JBrowseEntry(
 	-label => 'Scrolled List:',
 	-width => 12,
 	-default => $dbname5,
 	-height => 4,
 	-variable => \$dbname5,
 	-browsecmd => sub {print "-browsecmd!\n";},
 	-listcmd => sub {print "-listcmd!\n";},
 	-state => 'normal',
 	-choices => [qw(pigs cows foxes goats horses sheep dogs cats ardvarks default)]);
 $jb5->pack(
 	-side   => 'top', -pady => '10', -anchor => 'w');
 
 #HERE'S ONE THAT THE BUTTON TAKES KEYBOARD FOCUS.
 
 $jb6 = $MainWin->JBrowseEntry(
 	-label => 'Button Focus:',
 	-btntakesfocus => 1,
 	-arrowimage => $MainWin->Getimage('balArrow'),   #SPECIFY A DIFFERENT BUTTON IMAGE.
 	-farrowimage => $MainWin->Getimage('cbxarrow'),  #OPTIONAL 2ND IMAGE FOR BUTTON WHEN FOCUSED. 
 	-width => 12,
 	-height => 4,
 	-variable => \$dbname6,
 	-browsecmd => sub {print "-browsecmd!\n";},
 	-listcmd => sub {print "-listcmd!\n";},
 	-state => 'normal',
 	-choices => [qw(pigs cows foxes goats horses sheep dogs cats ardvarks default)]);
 $jb6->pack(
 	-side   => 'top', -pady => '10', -anchor => 'w');
 
 #HERE'S ONE THAT DOWS NOT TAKE KEYBOARD FOCUS.
 
 $jb7 = $MainWin->JBrowseEntry(
 	-label => 'Skip Focus:',
 	-takefocus => 0,
 	-width => 12,
 	-height => 4,
 	-variable => \$dbname7,
 	-browsecmd => sub {print "-browsecmd!\n";},
 	-listcmd => sub {print "-listcmd!\n";},
 	-state => 'normal',
 	-choices => [qw(pigs cows foxes goats horses sheep dogs cats ardvarks default)]);
 $jb7->pack(
 	-side   => 'top', -pady => '10', -anchor => 'w');
 
 $jb7->choices([qw(First Second Fifth Sixth)]);   #REPLACE LIST CHOICES!
 $jb7->insert(2, 'Third', 'Fourth');              #ADD MORE AFTER 1ST 2.
 $jb7->insert('end', [qw(Seventh Oops Eighth)]);  #ADD STILL MORE AT END.
 $jb7->delete(7);                                 #REMOVE ONE.
 
 $b = $MainWin->Button(-text => 'Quit', -command => sub {exit(); });
 $b->pack(-side => 'top');
 $jb1->focus;   #PICK ONE TO START WITH KEYBOARD FOCUS.
 
 MainLoop;

=cut

package Tk::JBrowseEntry;

use vars qw($VERSION);
$VERSION = '4.64';

use Tk;
use Carp;
use strict;

require Tk::Frame;
require Tk::LabEntry;

use base qw(Tk::Frame);
Construct Tk::Widget 'JBrowseEntry';

my ($BITMAP, $FOCUSEDBITMAP);

sub ClassInit
{
	my($class,$mw) = @_;

	unless(defined($BITMAP))
	{
		$BITMAP = __PACKAGE__ . "::downarrwow";

		if ($Tk::platform =~ /Win32/)
		{
			my $bits = pack("b10"x10,
					"..........",
					"..........",
					"..........",
					".#########",
					"..#######.",
					"...#####..",
					"....###...",
					".....#....",
					"..........",
					".........."
					);
			$mw->DefineBitmap($BITMAP => 10,10, $bits);
		}
		else
		{
			my $bits = pack("b11"x12,
					"....###....",
					"....###....",
					"....###....",
					"....###....",
					".#########.",
					"..#######..",
					"...#####...",
					"....###....",
					".....#.....",
					"...........",
					".#########.",
					".#########."
			);
			$mw->DefineBitmap($BITMAP => 11,12, $bits);
		}
		$FOCUSEDBITMAP = __PACKAGE__ . "::fdownarrow";

		if ($Tk::platform =~ /Win32/)
		{
			my $bits = pack("b10"x10,
					".#.#.#.#.#",
					".#.......#",
					"..........",
					".#########",
					"..#######.",
					".#.#####.#",
					"....###...",
					".#...#...#",
					"..........",
					".##.#.#.##"
			);
			$mw->DefineBitmap($FOCUSEDBITMAP => 10,10, $bits);
		}
	}
}

sub Populate
{
	my ($w, $args) = @_;
#foreach my $i (keys %{$args}) {print "-args($i)=$args->{$i}=\n"; };
	$w->{btntakesfocus} = 0;
	$w->{btntakesfocus} = delete ($args->{-btntakesfocus})  if (defined($args->{-btntakesfocus}));
	$w->{arrowimage} = $args->{-arrowimage}  if (defined($args->{-arrowimage}));
	$w->{farrowimage} = delete ($args->{-farrowimage})  if (defined($args->{-farrowimage}));
	$w->{arrowimage} ||= $w->{farrowimage}  if ($w->{farrowimage});
	$w->{takefocus} = 1;
	$w->{takefocus} = delete ($args->{-takefocus})  if (defined($args->{-takefocus}));
	$w->{-listwidth} = $args->{-width}  if (defined($args->{-width}));
	$w->{-maxwidth} = delete($args->{-maxwidth})  if (defined($args->{-maxwidth}));
	$w->{-foreground} = $args->{-foreground}  if (defined($args->{-foreground}));
	$w->{-background} = $w->parent->cget(-background) || 'gray';
	$w->{-background} = $args->{-background}  if (defined($args->{-background}));
	$w->{-textbackground} = delete($args->{-textbackground})  if (defined($args->{-textbackground}));
	$w->{-textforeground} = delete($args->{-textforeground})  if (defined($args->{-textforeground}));
#unless ($^O =~ /Win/i)  #FOR SOME REASON, THIS IS NEEDED IN LINUX?
{
	$w->{-disabledbackground} = delete($args->{-disabledbackground})  if (defined($args->{-disabledbackground}));
	$w->{-disabledforeground} = delete($args->{-disabledforeground})  if (defined($args->{-disabledforeground}));
}
	$w->{-foreground} = $w->parent->cget(-foreground);
	#$w->{-borderwidth} = 2;
	$w->{-borderwidth} = delete($args->{-borderwidth})  if (defined($args->{-borderwidth}));
	$w->{-relief} = 'sunken';
	$w->{-relief} = delete($args->{-relief})  if (defined($args->{-relief}));
	$w->{-listrelief} = 'sunken';
	$w->{-listrelief} = delete($args->{-listrelief})  if (defined($args->{-listrelief}));
	$w->{-listfont} = delete($args->{-listfont})  if (defined($args->{-listfont}));
	$w->{-noselecttext} = delete($args->{-noselecttext})  if (defined($args->{-noselecttext}));
	$w->{-browse} = 0;
	$w->{-browse} = delete($args->{-browse})  if (defined($args->{-browse}));
	$w->{-tabcomplete} = 0;
	$w->{-tabcomplete} = delete($args->{-tabcomplete})  if (defined($args->{-tabcomplete}));
	$w->{-altbinding} = 0;  #NEXT 2 ADDED 20050112 TO SUPPORT ALTERNATE KEY-ACTION MODELS.
	$w->{-altbinding} = delete($args->{-altbinding})  if (defined($args->{-altbinding}));
	#NEXT LINE ADDED 20060429 TO SUPPORT OPTION FOR USER DELETION OF LISTBOX ITEMS.
	$w->{-deleteitemsok} = delete($args->{-deleteitemsok})  if (defined($args->{-deleteitemsok}));
#print STDERR "-altbinding=$w->{-altbinding}= w=$w=\n";
#	unless (defined($w->{-noselecttext}))
#	{
#		$w->{-noselecttext} = 1  if ($args->{-state} eq 'readonly');
#	}
	my $lpack = delete $args->{-labelPack};   #MOVED ABOVE SUPER:POPULATE 20050120.
	$w->SUPER::Populate($args);

	# ENTRY WIDGET AND ARROW BUTTON

	unless (defined $lpack)
	{
		$lpack = [-side => "left", -anchor => "e"];
	}
	my $labelvalue = $args->{-label};

	my $ll = $w->Label(-text => delete $args->{-label});
	my $tf = $w->Frame(-borderwidth => ($w->{-borderwidth} || 2), -highlightthickness => 1, 
			-relief => ($w->{-relief} || 'sunken'));
	my $e = $tf->LabEntry(-borderwidth => 0, -relief => 'flat');
	# FOR SOME REASON, E HAS TO BE A LABENTRY, JUST PLAIN ENTRY WOULDN'T TAKE KEYBOARD EVENTS????
 $w->ConfigSpecs(DEFAULT => [$e]);
	my $b = $tf->Button(-borderwidth => 1, -takefocus => $w->{btntakesfocus}, 
			#-bitmap => '@' . Tk->findINC("balArrow.xbm"));
			-bitmap => $BITMAP);
			#-bitmap => '@' . Tk->findINC("cbxarrow.xbm"));
	#$ll->packForget()  unless ($labelvalue);
	if ($labelvalue)
	{
		$ll->pack(@$lpack);
	}
	else
	{
		$ll->packForget();   # REMOVE LABEL, IF NO VALUE SPECIFIED.
	}
	$w->Advertise("entry" => $e);   #TEXT PART.
	$w->Advertise("arrow" => $b);   #ARROW BUTTON PART.
	$w->Advertise("frame" => $tf);  #SURROUNDING FRAME PART.
	my ($ee) = $w->Subwidget("entry");
	$w->Advertise("textpart" => $ee);   #TEXT COMPONENT OF LABENTRY WIDGET.
	$tf->pack(-side => "right", -padx => 0, -pady => 0, -fill => 'x', -expand => 1);
	$b->pack(-side => "right", -padx => 0, -pady => 0, -fill => 'y');
	$e->pack(-side => "right", -fill => 'x', -padx => 0, -pady => 0, -expand => 1); #, -padx => 1);

	# POPUP SHELL FOR LISTBOX WITH VALUES.

	my $c = $w->Toplevel(-bd => 2, -relief => "raised");
	$c->overrideredirect(1);
	$c->withdraw;
	my $sl = $c->Scrolled( qw/Listbox -selectmode browse -scrollbars oe/ );

	# PROPOGATE FORE & BACKGROUND COLORS TO ALL WIDGETS, IF SPECIFIED.

	if (defined($w->{-foreground}))
	{
		$e->configure(-foreground => $w->{-foreground}, -highlightcolor => $w->{-foreground});
		$tf->configure(-foreground => $w->{-foreground}, -highlightcolor => $w->{-foreground});
		$sl->configure(-foreground => $w->{-foreground}, -highlightcolor => $w->{-foreground});
		$b->configure(-foreground => $w->{-foreground}, -highlightcolor => $w->{-foreground});
	}
	if (defined($w->{-listrelief}))
	{
		$sl->configure(-relief => ($w->{-listrelief}||'sunken'));
	}
	if (defined($w->{-background}) || defined($w->{-textbackground}))
	{
		$e->configure(-background => ($w->{-textbackground}||$w->{-background}), -highlightbackground => $w->{-background});
		$tf->configure(-background => $w->{-background}, -highlightbackground => $w->{-background});
		$sl->configure(-background => $w->{-background}, -highlightbackground => $w->{-background});
		$b->configure(-background => $w->{-background}, -highlightbackground => $w->{-background});
	}
	elsif ($^O =~ /Win/i)   # SET BACKGROUND TO WINDOWS DEFAULTS (IF NOT SPECIFIED)
	{
		$sl->configure( -background => 'SystemWindow' );
	}
	if ($^O =~ /Win/i)
	{
		$sl->configure( -borderwidth => 1);
		$c->configure( -borderwidth => ($w->{-borderwidth}||0), -relief => 'ridge' );
	}
	if (defined($w->{-disabledforeground}))   #THIS ERRS ON LINUX SOMETIMES?!
	{
		eval { $e->Subwidget("entry")->configure(-disabledforeground => $w->{-disabledforeground}); };
	}
	if (defined($w->{-disabledbackground}))
	{
		eval { $e->configure(-disabledbackground => $w->{-disabledbackground}); };
	}
	$sl->configure(-font => $w->{-listfont})  if ($w->{-listfont});
	$w->Advertise("choices" => $c);   #LISTBOX POPUP MAIN WINDOW PART.
	$w->Advertise("slistbox" => $sl); #ACTUAL LISTBOX ITSELF.
	$sl->pack(-expand => 1, -fill => "both");

	# OTHER INITIALIZATIONS.

	$w->SetBindings;
	$w->{"popped"} = 0;
	$w->Delegates('insert' => $sl, 'delete' => $sl, get => $sl, DEFAULT => $e);
	$w->ConfigSpecs(
			-listwidth   => [qw/PASSIVE  listWidth   ListWidth/,   undef],
			-maxwidth   => [qw/PASSIVE  maxWidth   MaxWidth/,   undef],
			-height      => [qw/PASSIVE  height      Height/,      undef],
			-listcmd     => [qw/CALLBACK listCmd     ListCmd/,     undef],
			-browsecmd   => [qw/CALLBACK browseCmd   BrowseCmd/,   undef],
			-choices     => [qw/METHOD   choices     Choices/,     undef],
			-state       => [qw/METHOD   state       State         normal/],
			-arrowimage  => [ {-image => $b}, qw/arrowImage ArrowImage/, undef],
			-variable    => "-textvariable",
			-colorstate  => [qw/PASSIVE  colorState  ColorState/,  undef],
			-default   => "-textvariable", 
			-imgname   => '',
			-img0      => '',
			-img1      => '',
	DEFAULT      => [$e] );

	my $var_ref = $w->cget( "-textvariable" );

	#SET UP DUMMY SO IT DISPLAYSS IF NO VARIABLE SPECIFIED.

	unless (defined($var_ref) && ref($var_ref))
	{
		$var_ref = '';
		$w->configure(-textvariable => \$var_ref);
	}

	eval { $w->{'default'} = $_[1]->{'-default'} || ${$_[1]->{-variable}}; }; 
}

sub focus
{
	my ($w) = shift;
	my ($state) = $w->cget( "-state" );

	if ($state eq 'disabled')   #MOVE FOCUS ON TO NEXT WIDGET (DON'T TAKE FOCUS).
	{
		eval {$w->focusNext->focus; };
	}
	else
	{
		if ($w->{'savefocus'} && Tk::Exists($w->{'savefocus'}))
		{
			$w->{'savefocus'}->focus;
		}
		elsif ($state eq 'readonly')   #FRAME GETS FOCUS IF READONLY.
		{
			$w->Subwidget("frame")->focus;
		}
		else                        #OTHERWISE, TEXT ENTRY COMPONENT DOES.
		{
			$w->Subwidget("entry")->focus;
		}
		delete $w->{'savefocus'};

		#BUTTON GETS FOCUS IF BUTTON TAKES FOCUS, BUT WIDGET ITSELF DOESN'T.

		$w->Subwidget("arrow")->focus  if (!$w->{takefocus} && $w->{btntakesfocus});
		$w->Subwidget("entry")->icursor('end');
		unless ($w->{-noselecttext} || !$w->Subwidget("entry")->index('end'))
		{
			$w->Subwidget("entry")->selectionRange(0,'end'); #  unless ($state eq 'readonly' && $w->{btntakesfocus});
		}		
	}
}

sub SetBindings
{
	my ($w) = @_;

	my $e = $w->Subwidget("entry");
	my $f = $w->Subwidget("frame");
	my $b = $w->Subwidget("arrow");
	my $sl = $w->Subwidget("slistbox");
	my $l = $sl->Subwidget("listbox");

	local *returnFn = sub   #HANDLES RETURN-KEY PRESSED IN ENTRY AREA.
	{
		my $altbinding = $w->{-altbinding};
		if ($altbinding =~ /Return\=Next/i)
		{
			$w->Popdown  if  ($w->{"popped"});   #UNDISPLAYS LISTBOX.
			$w->Callback(-browsecmd => $w, $w->Subwidget('entry')->get, 'entry.return')
					if ($w->{-browse} == 1);
			eval { shift->focusNext->focus; };
			Tk->break;
		}
		my ($state) = $w->cget( "-state" );
	
		&LbFindSelection($w);
		unless ($w->{"popped"})
		{
			$w->BtnDown;
			return if ($state =~ /text/ || $state eq 'disabled');
			$w->{'savefocus'} = $w->focusCurrent;
			$w->Subwidget("slistbox")->focus;
		}
		else
		{
			$w->LbCopySelection(0,'entry.enter');
			$e->selectionRange(0,'end')  unless ($w->{-noselecttext} || !$e->index('end'));
			$e->icursor('end');
			Tk->break;
		}
	};

	local *downFn = sub   #HANDLES DOWN-ARROW PRESSED IN ENTRY AREA.
	{
		my $altbinding = $w->{-altbinding};
#print STDERR "-altbinding=$altbinding/$w->{-altbinding}= w=$w=\n";
		my ($state) = $w->cget( "-state" );
		return  if ($state eq 'textonly' || $state eq 'disabled');
		&LbFindSelection($w); 
		if ($altbinding =~ /Down\=Popup/i)  #MAKE DOWN-ARROW POP UP DD-LIST.
		{
			unless ($w->{"popped"})
			{
				$w->BtnDown;
				return if ($state =~ /text/ || $state eq 'disabled');
				$w->{'savefocus'} = $w->focusCurrent;
				$w->Subwidget("slistbox")->focus;
			}
			else
			{
				$w->LbCopySelection(0,'entry.enter');
				$e->selectionRange(0,'end')  unless ($w->{-noselecttext} || !$e->index('end'));
				$e->icursor('end');
				Tk->break;
			}
			return;
		}
		if ($w->{"popped"})
		{
			return if ($state eq 'text');
			&LbFindSelection($w); 
			$w->{'savefocus'} = $w->focusCurrent;
			$w->Subwidget("slistbox")->focus;
		}
		else
		{
			&LbFindSelection($w); 
			my $l = $w->Subwidget("slistbox")->Subwidget("listbox");
			my (@listsels) = $l->get('0','end');
			my $index = $w->LbIndex;
			if (&LbFindSelection($w) == 1)
			{
				$index += 1;
				$index = 0  if ($index > $#listsels);
			}
			my $var_ref = $w->cget( "-textvariable" );
			$$var_ref = $listsels[$index];
			$e->icursor('end');
			$e->selectionRange(0,'end')  unless ($w->{-noselecttext} || !$e->index('end'));
		}
	};
	
	local *upFn = sub   #HANDLES UP-ARROW PRESSED IN ENTRY AREA.
	{
		my ($state) = $w->cget( "-state" );
		return  if ($state eq 'textonly' || $state eq 'disabled');
		if ($w->{"popped"})
		{
			return if ($state eq 'text');
			&LbFindSelection($w);
			$w->{'savefocus'} = $w->focusCurrent;
			$w->Subwidget("slistbox")->focus;
		}
		else
		{
			&LbFindSelection($w);
			my $l = $w->Subwidget("slistbox")->Subwidget("listbox");
			my (@listsels) = $l->get('0','end');
			my $index = $w->LbIndex - 1;
			$index = $#listsels  if ($index < 0);
			my $var_ref = $w->cget( "-textvariable" );
			$$var_ref = $listsels[$index];
			$e->icursor('end');
			$e->selectionRange(0,'end')  unless ($w->{-noselecttext} || !$e->index('end'));
		}
	};

	local *escapeFn = sub   #HANDLES ESCAPE-KEY PRESSED IN ENTRY AREA.
	{
		if ($w->{"popped"})
		{
			$w->Popdown;
		}
		else
		{
			my $var_ref = $w->cget( "-textvariable" );
			#if ($$var_ref eq $w->{'default'} && $w->cget( "-state" ) ne "readonly")
			#CHGD. TO NEXT 20030531 PER PATCH BY FRANK HERRMANN.
			if (defined $w->{'default'} and $$var_ref eq $w->{'default'} 
					and $w->cget( "-state" ) ne "readonly")
			{
				$$var_ref = '';
			}
			else
			{
				$$var_ref = $w->{'default'};
			}
			$e->icursor('end');
		}
		$e->selectionRange(0,'end')  unless ($w->{-noselecttext} || !$e->index('end'));   #ADDED 20020716
		Tk->break;
	};

	local *spacebarFn = sub   #HANDLES RETURN-KEY PRESSED IN ENTRY AREA.
	{
		my ($state) = $w->cget( "-state" );
	
		if ($state eq 'readonly')
		{
			&LbFindSelection($w);
			unless ($w->{"popped"})
			{
				$w->BtnDown;
				return if ($state =~ /text/ || $state eq 'disabled');
				$w->{'savefocus'} = $w->focusCurrent;
				$w->Subwidget("slistbox")->focus;
			}
			else
			{
				$w->LbCopySelection(0,'entry.space');
				$e->selectionRange(0,'end')  unless ($w->{-noselecttext} || !$e->index('end'));
				$e->icursor('end');
				Tk->break;
			}
		}
	};

	# SET BIND TAGS

	$w->bindtags([$w, 'Tk::JBrowseEntry', $w->toplevel, "all"]);
	$e->bindtags([$e, $e->toplevel, "all"]);

	# IF USER-SPECIFIED IMAGE(S), CHANGE BUTTON IMAGE WHEN GETTING/LOSING FOCUS.

	$b->bind("<FocusIn>", sub
	{
		$b = shift;
		my ($state) = $w->cget( "-state" );
		my $img = $w->{farrowimage} || $b->cget('-image');
		if ($img)
		{
			unless ($w->{img0})
			{
				$w->{img0} = $img;
			}
			$b->configure(-image => $w->{img0});					
		}
		elsif ($^O =~ /Win/i)
		{
			$w->{img0} = $FOCUSEDBITMAP;
			$b->configure(-bitmap => $w->{img0});
		}
		$w->{imgname} = 'cbfarrow';
		$w->{savehl} = $f->cget(-highlightcolor);
		my $framehlcolor;
		if ($^O =~ /Win/i)
		{
			$framehlcolor = $w->{-background} || 'SystemButtonFace';
		}
		else
		{
			$framehlcolor = $w->{-background} || $e->cget( -background );
		}
		$f->configure(-highlightcolor => $framehlcolor);
	}
	);

	$b->bind("<FocusOut>", sub
	{
		$b = shift;
		my ($state) = $w->cget( "-state" );
		my $img = $w->{arrowimage} || $b->cget('-image');
		if ($img)
		{
			unless ($w->{img1})
			{
				$w->{img1} = $img;
			}
			$b->configure(-image => $w->{img1});					
		}
		elsif ($^O =~ /Win/i)
		{
			$w->{img1} = $BITMAP;
			$b->configure(-bitmap => $w->{img1});
		}
		$w->{imgname} = 'cbxarrow';
		$f->configure(-highlightcolor => $w->{savehl})  if ($w->{savehl});
	}
	);

	$b->bind('<1>', sub   #MOUSE CLICKED ON BUTTON.
	{
		my ($state) = $b->cget( "-state" );
		unless ($state eq 'disabled')
		{
			&LbFindSelection($w)  if ($w->{popped}); 
			$w->BtnDown;    #POPS UP LISTBOX!
			if ($w->{popped})
			{
				my $index = $w->LbIndex;
				$index = 0  if (!defined($index) || $index < 0);
				$l->focus;
				$l->activate($index);      #THIS UNDERLINES IT.
				$l->selectionClear(0,'end');  #THIS HIGHLIGHTS IT (NEEDED 1ST TIME?!)
				$l->selectionSet($index);  #THIS HIGHLIGHTS IT (NEEDED 1ST TIME?!)
			}
			$w->LbCopySelection(1,'buttondown.button1');
		}
		Tk->break;
	}
	);

	$b->bind("<ButtonRelease-1>", sub {
		my ($state) = $b->cget( "-state" );
		if ($state ne 'disabled' && $w->{'popped'})   #LISTBOX IS SHOWING
		{
			$w->LbCopySelection(1,'buttonup.button1');
		}
		Tk->break;
	}
	);

	$b->bind("<space>", sub
	{
		my ($state) = $w->cget( "-state" );
		return if ($state =~ /text/ || $state eq 'disabled');

		&LbFindSelection($w);
		$w->BtnDown;
		$w->{'savefocus'} = $b || $w->focusCurrent;
		$w->Subwidget("slistbox")->focus;
	}
	);

	$b->bind("<Return>", sub
	{
		my ($state) = $w->cget( "-state" );
		return if ($state =~ /text/ || $state eq 'disabled');

		&LbFindSelection($w);
		$w->BtnDown;
		$w->{'savefocus'} = $b || $w->focusCurrent;
		$w->Subwidget("slistbox")->focus;
		Tk->break;
	}
	);

	$b->bind("<Down>", sub
	{
		my ($state) = $w->cget( "-state" );
		return if ($state =~ /text/ || $state eq 'disabled');

		&LbFindSelection($w);
		$w->BtnDown;
		$w->{'savefocus'} = $b || $w->focusCurrent;
		$w->Subwidget("slistbox")->focus;
		Tk->break;
	}
	);

	$e->bind("<Return>", \&returnFn);
	$f->bind("<Return>", \&returnFn);

	$e->bind("<Down>", \&downFn);
	$f->bind("<Down>", \&downFn);

	$e->bind("<space>", \&spacebarFn);
	$f->bind("<space>", \&spacebarFn);

	$e->bind("<Up>", \&upFn);
	$f->bind("<Up>", \&upFn);

	$e->bind('<Escape>' => \&escapeFn);
	$f->bind('<Escape>' => \&escapeFn);

	$e->bind("<Left>", sub {Tk->break;});
	$e->bind("<Right>", sub {Tk->break;});
	$f->bind("<Left>", sub {Tk->break;});
	$f->bind("<Right>", sub {Tk->break;});

	$e->bind("<Tab>", sub
	{
		my $same = 1;
		#NEXT LINE ADDED 20030531 PER PATCH BY FRANK HERRMANN.
		$w->Callback(-browsecmd => $w, $w->Subwidget('entry')->get, 'entry.tab')
				if ($w->{-browse} == 1);
		if ($w->{-tabcomplete})
		{
			my $var_ref = $w->cget( "-textvariable" );
			if (&LbFindSelection($w))
			{
				my @listsels = $l->get('0','end');
				my $index = $w->LbIndex;
				unless ($$var_ref eq $listsels[$index])
				{
					$$var_ref = $listsels[$index];
					$e->icursor('end');
					$same = 0;
				}
			}
			elsif ($w->{-tabcomplete} == 2)
			{
				#THIS CODE FORCES TAB TO CHANGE TEXT ENTERED TO A LIST ITEM!
				#THIS SUCKS IF THERE IS NO LIST OR USER WISHES TO OVERRIDE!
				unless ($$var_ref eq ((defined $w->{'default'}) ? $w->{'default'} : ''))
				{
					if (defined $w->{'default'})
					{
						$$var_ref = $w->{'default'};
					}
					else
					{
						$$var_ref = '';
					}
					$e->icursor('end');
					$same = 0;
				}
			}
			$e->selectionRange(0,'end')  unless ($w->{-noselecttext} || !$e->index('end'));
		}
		if  ($w->{"popped"})   #UNDISPLAYS LISTBOX.
		{
			$w->Popdown;
		}
		eval { shift->focusNext->focus; }  if ($same);
		Tk->break;
	}
	);

	$f->bind("<Tab>", sub
	{
		#NEXT LINE ADDED 20030531 PER PATCH BY FRANK HERRMANN.
		$w->Callback(-browsecmd => $w, $w->Subwidget('entry')->get, 'frame.tab')
				if ($w->{-browse} == 1);
		$w->Popdown  if  ($w->{"popped"});
		eval { shift->focusNext->focus; };
	}
	);

	# KEYBOARD BINDINGS FOR LISTBOX

	$l->configure(-selectmode => 'browse');
	$l->configure(-takefocus => 1); 
	$l->bind("<ButtonRelease-1>", sub
	{
		$w->ButtonHack;
		LbChoose($w, $l->XEvent->x, $l->XEvent->y);
		Tk->break;     #ADDED 20050210.
	}
	);
	$l->bind('<Escape>' => sub
	{
		$w->LbClose;
		Tk->break;
	}
	);
	$l->bind('<Return>' => sub
	{
		$w->LbCopySelection(0,'listbox.enter');
		#$e->selectionRange(0,'end')  unless ($w->{-noselecttext} || !$e->index('end'));
		#$e->icursor('end');
		Tk->break;
	}
	);
	$l->bind('<space>' => sub
	{
		my ($state) = $w->cget( "-state" );
		$w->LbCopySelection(0,'listbox.space');
		$e->selectionRange(0,'end')  unless ($w->{-noselecttext} || !$e->index('end'));
		$e->icursor('end');
		$w->{'savefocus'} = $w->focusCurrent;  #ADDED 20060621 TO ALLOW JFILEDIALOG TO SET FOCUS TO ANOTHER WIDGET WHEN USER SELECTS VIA SPACEBAR.
		Tk->break;
	}
	);

	$l->bind('<Tab>' => sub
	{
		my ($state) = $w->cget( "-state" );
		$w->Popdown  if ($^O !~ /Win/i && !$w->{takefocus});  #WINDUHS LOWERS LISTBOX BEHIND CALLER (HIDES IT)!
		$w->Popdown  if ($^O =~ /Win/i || $state eq 'readonly');  #WINDUHS LOWERS LISTBOX BEHIND CALLER (HIDES IT)!
		$e->focus()  unless ($state eq 'readonly');  #SO WE'LL POP IT DOWN FIRST! (RAISE WOULDN'T WORK :-()
		$w->BtnDown  if ($^O =~ /Win/i && $state ne 'readonly' && $w->{takefocus});
		if ($w->{-tabcomplete})
		{
			&LbFindSelection($w);
			my @listsels = $l->get('0','end');
			my $index = $w->LbIndex;
			my $var_ref = $w->cget( "-textvariable" );
			unless ($$var_ref eq $listsels[$index])
			{
				$$var_ref = $listsels[$index];
				$e->icursor('end');
			}
			$e->selectionRange(0,'end')  unless ($w->{-noselecttext} || !$e->index('end'));
		}
		Tk->break;
	}
	);
	$l->bind('<Delete>' => sub { $w->delete($w->LbIndex) })   #ADDED 20060429 TO SUPPORT OPTION FOR USER DELETION OF LISTBOX ITEMS.
			if ($w->{-deleteitemsok});
	$l->bind('<Key>' => [\&keyFn,$w,$e,$l,1]);  
			#if $w->cget( "-state" ) eq "readonly";
	$e->bind('<Key>' => [\&keyFn,$w,$e,$l]);
	$f->bind('<Key>' => [\&keyFn,$w,$e,$l]);
			#unless $w->cget( "-state" ) eq "readonly";
	$e->bind('<1>' => sub { 
		my ($state) = $w->cget( "-state" );
		if ($state eq 'readonly')
		{
			&LbFindSelection($w);
			if ($w->{"popped"})
			{
				$w->Popdown(1);
			}
			else
			{
				$w->BtnDown;
			}
	     		$w->{'savefocus'} = $w->focusCurrent;
 	    		$w->Subwidget("slistbox")->focus;
 	    		Tk->break;
		}
		else
		{
			if ($w->{"popped"})
			{
				$w->Popdown(1);
			}
			$e->focus;
 	    		Tk->break;
		}
	});

	#NEXT 3 LINES ADDED 20030531 PER PATCH BY FRANK HERRMANN.
	$e->bind('<2>' => sub { 
		$e->focus;
	});

	# ALLOW CLICK OUTSIDE THE POPPED UP LISTBOX TO POP IT DOWN.

	$w->bind("<1>", sub {$w->BtnDown; Tk->break});
	$w->parent->bind("<1>", sub
	{
		if ($w->{"popped"})
		{
			$w->Popdown(1);
		}
	}
	);
	$w->bind("<FocusIn>", \&focus);
	$w->bind('<Alt-f>', sub {print "-focus=".$w->focusCurrent()."=\n";});
	$w->bind('<ButtonRelease-2>', sub {print "-focus=".$w->focusCurrent()."=\n";});
}

sub keyFn   #JWT: TRAP LETTERS PRESSED AND ADJUST SELECTION ACCORDINGLY.
{
	my ($x,$w,$e,$l,$flag) = @_;
	my $mykey = $x->XEvent->A;

	#NEXT LINE ADDED 20030531 PER PATCH BY FRANK HERRMANN.
	$w->Callback(-browsecmd => $w, $w->Subwidget('entry')->get, "key.$mykey")
			if ($w->{-browse} == 1);

	if ($w->cget( "-state" ) eq "readonly")  #ADDED 20020711 TO ALLOW TYPING 1ST LETTER TO SELECT NEXT VALID ITEM!
	{
		&LbFindSelection($w,$mykey)  if ($mykey);  #JUMP TO 1ST ITEM STARTING WITH THIS KEY
		$w->LbCopySelection(1,'key.$mykey');
		$w->Subwidget("entry")->selectionRange(0,'end')  unless ($w->{"popped"} 
				|| $w->{-noselecttext} || !$w->Subwidget("entry")->index('end'));
		$e->icursor('end');
	}
	elsif (defined $flag and $flag == 1)      #LISTBOX HAS FOCUS.
	{
		&LbFindSelection($w,$mykey)  if ($mykey);  #JUMP TO 1ST ITEM STARTING WITH THIS KEY
	}
	else  #TEXT FIELD HAS FOCUS.
	{
		&LbFindSelection($w)  if ($mykey);  #JUMP TO 1ST ITEM MATCHING TEXT FIELD.
	}

}

sub BtnDown
{
	my ($w) = @_;
	my ($state) = $w->cget( "-state" );

	return if ($state =~ /text/ || $state eq 'disabled');

	#JWT:   NEXT 2 LINES PREVENT POPPING EMPTY LIST!

	my $l = $w->Subwidget("slistbox")->Subwidget("listbox");
	return  unless ($l->get('0','end'));

	if ($w->{"popped"})
	{
		$w->Popdown(1);
		$w->{"buttonHack"} = 0;
	}
	else
	{
		$w->PopupChoices;
		$w->{"buttonHack"} = 1;
	}
}

sub PopupChoices
{
	my ($w) = @_;

	my $first;

	if (!$w->{"popped"})
	{
		$w->Callback(-listcmd, $w);
		my $e = $w->Subwidget("entry");
		my $c = $w->Subwidget("choices");
		my $s = $w->Subwidget("slistbox");
		my $a = $w->Subwidget("arrow");

		my $wheight = $w->cget("-height");
		my (@hh);
		$hh[0]=$w->height;
		$hh[1]=$w->reqheight;
		$hh[2]=$e->height;
		$hh[3]=$e->reqheight;
		$hh[4]=$c->height;
		$hh[5]=$c->reqheight;
		$hh[6]=$s->height;
		$hh[7]=$s->reqheight;

		my $sll = $s->Subwidget("listbox");
		my $rw = $c->width; 
		$first = 1  if ($rw <= 1);
		my ($itemcnt) = $sll->index('end');
		$wheight = 10  unless ($wheight);
		$wheight = $itemcnt  if ($itemcnt < $wheight);
		$wheight = $itemcnt  unless ($wheight);
		$wheight = $itemcnt  unless ($wheight || $itemcnt > 10);
		if ($wheight)
		{
			$sll->configure(-height => ($wheight * $w->height));
			$w->update;
		}

		my $y1 = $e->rooty + $e->height + 3;
		#my $bd = $c->cget(-bd) + $c->cget(-highlightthickness);  #CHGD. TO NEXT 20050120.
		my $bd = $c->cget(-bd);
		my ($unitpixels, $ht, $x1, $ee, $width, $x2);
		if ($^O =~ /Win/i)
		{
			$y1 -= 3 - ($w->{-borderwidth} || 2);
			#$unitpixels = $e->height + 1;  #CHGD. TO NEXT 20040827 - WINBLOWS XP SEEMS TO NOT BEVEL THE HIGHLIGHT CURSOR, 
			$unitpixels = $e->height - 1;   #SO THE WIDTH OF EACH ITEM IS NOW 2 PIXELS SMALLER! (USE OLD LINE, IF BEVELLED)!
			$ht = ($wheight * $unitpixels) + (2 * $bd) + 4;
			$ee = $w->Subwidget("frame");
			$x1 = $ee->rootx;
			$x2 = $a->rootx + $a->width;
			$width = $x2 - $x1;
			#$rw = $width + $w->{-borderwidth};
			#CHGD. TO NEXT 20030531 PER PATCH BY FRANK HERRMANN.
			$rw = ($width || 0) + ($w->{-borderwidth} || 0);
			$x1 += 1;  #FUDGE MORE FOR WINDOWS (THINNER BORDER) TO MAKE DROPDOWN LINE UP VERTICALLY W/ENTRY&BUTTON.
		}
		else
		{
			$y1 -= 3 - ($w->{-borderwidth} || 2);
			#$unitpixels = $e->height - 1;   #CHGD. TO NEXT 2 20050120.
			$unitpixels = $e->height - (2*$w->cget(-highlightthickness));
			$unitpixels += 1;
			$ht = ($wheight * $unitpixels) + (2 * $bd) + 6;
			$ee = $w->Subwidget("frame");
			$x1 = $ee->rootx;
			$x2 = $a->rootx + $a->width;
			$width = $x2 - $x1;
#			if ($rw < $width)   #NEXT 10 LINES REPLACED BY FOLLOWING LINE 20020815.
#			{
#				$rw = $width;
#			}
#			else
#			{
#				$rw = $width * 3  if ($rw > $width * 3);
#				$rw = $w->vrootwidth  if ($rw > $w->vrootwidth);
#			}
#			$width = $rw;   #REMOVED 20020815 - UNNECESSARY!
$rw = $width;    #ADDED 20020815 TO CAUSE LISTBOX TO ADJUST WIDTH TO SAME AS VARYING ENTRY FIELD!
			if ($first)
			{
				#NEXT LINE ADDED 20030531 PER PATCH BY FRANK HERRMANN.
				$w->{-borderwidth} = 0 unless(defined $w->{-borderwidth});	# XXX
				$rw += 1 + int($w->{-borderwidth} / 2);
				$first = 0;
			}

			# IF LISTBOX IS TOO FAR RIGHT, PULL IT BACK TO THE LEFT

			if ($x2 > $w->vrootwidth)
			{
				$x1 = $w->vrootwidth - $width;
			}
			$x1 += 1;  #FUDGE MORE FOR WINDOWS (THINNER BORDER) TO MAKE DROPDOWN LINE UP VERTICALLY W/ENTRY&BUTTON.
		}

		# IF LISTBOX IS TOO FAR LEFT, PULL IT BACK TO THE RIGHT

		if ($x1 < 0)
		{
			$x1 = 0;
		}

		# IF LISTBOX IS BELOW BOTTOM OF SCREEN, PULL IT UP.

		my $y2 = $y1 + $ht;
		if ($y2 > $w->vrootheight)
		{
			$y1 = $y1 - $ht - ($e->height - 5);
		}
		$c->geometry(sprintf("%dx%d+%d+%d", $rw, $ht, $x1, $y1));
		$c->deiconify;
		$c->raise;
		$w->focus;
		$w->{"popped"} = 1;

		&LbFindSelection; 
		$c->configure(-cursor => "arrow");
		$w->grabGlobal;
	}
}

# CHOOSE VALUE FROM LISTBOX IF APPROPRIATE.

sub LbChoose
{
	my ($w, $x, $y) = @_;
	my $l = $w->Subwidget("slistbox")->Subwidget("listbox");
	$l->configure(-selectmode => 'browse');
	if ((($x < 0) || ($x > $l->Width)) ||
			(($y < 0) || ($y > $l->Height)))
	{
		# MOUSE WAS CLICKED OUTSIDE THE LISTBOX... CLOSE THE LISTBOX
		$w->LbClose;
	}
	else
	{
		# SELECT APPROPRIATE ENTRY AND CLOSE THE LISTBOX
		$w->LbCopySelection(0,'listbox.button1');
	}
}

# CLOSE THE LISTBOX AFTER CLEARING SELECTION.

sub LbClose
{
	my ($w) = @_;
	my $l = $w->Subwidget("slistbox")->Subwidget("listbox");
	$l->configure(-selectmode => 'browse');
	$l->selection("clear", 0, "end");
	$w->Popdown;
}

# COPY THE SELECTION TO THE ENTRY, AND CLOSE LISTBOX (UNLESS JUSTCOPY SET).

sub LbCopySelection
{
	my ($w, $justcopy, $action) = @_;
	my $index = $w->LbIndex;
	if (defined $index)
	{
		$w->{"curIndex"} = $index;
		my $l = $w->Subwidget("slistbox")->Subwidget("listbox");
		$l->configure(-selectmode => 'browse');
		my $var_ref = $w->cget( "-textvariable" );
		$$var_ref = $l->get($index);
		my $e = $w->Subwidget("entry");
		$e->icursor('end');
	}
	#$w->Popdown  if ($w->{"popped"} && !$justcopy);
	if ($w->{"popped"} && !$justcopy)
	{
		$w->Popdown;
		$w->Callback(-browsecmd => $w, $w->Subwidget('entry')->get, $action);
	}
}

# GRAB TEXT TYPED IN AND FIND NEAREST ENTRY IN LISTBOX AND SELECT IT.
# LETTERSEARCH SET MEANS SEARCH FOR *NEXT* MATCH OF SPECIFIED LETTER,
# CLEARED MEANS SEARCH FOR *1ST* ITEM STARTING WITH CURRENT TEXT ENTRY VALUE.

sub LbFindSelection
{
	my ($w, $srchval) = @_;

	my $lettersearch = 0;
	if ($srchval)
	{
		$lettersearch = 1;
	}
	else
	{
		my $var_ref = $w->cget( "-textvariable" );
		$srchval = $$var_ref;
	}
	my $l = $w->Subwidget("slistbox")->Subwidget("listbox");
	$l->configure(-selectmode => 'browse');
	my (@listsels) = $l->get('0','end');
	unless ($lettersearch)
	{
		foreach my $i (0..$#listsels)   #SEARCH FOR TRUE EQUALITY.
		{
			if ($listsels[$i] eq $srchval)
			{
				$l->selectionClear('0','end');
				$l->activate($i);
				$l->selectionSet($i);
				$l->update();
				$l->see($i);
				return 1;
			}
		}
	}
	my $index = $w->LbIndex;   #ADDED 20020711 TO ALLOW WRAPPING IF SAME LETTER PRESSED AGAIN!

	foreach my $i (0..$#listsels)   #SEARCH W/O REGARD TO CASE, START W/CURRENT SELECTION.
	{
		++$index;
		$index = 0  if ($index > $#listsels);
		#if ($listsels[$index] =~ /^$srchval/i)
		#CHGD. TO NEXT 20030531 PER PATCH BY FRANK HERRMANN.
#		if (defined $srchval && $listsels[$index] =~ /^$srchval/i) #CHGD TO NEXT 20060429 TO PREVENT TK-ERROR ON "("!
		if (defined $srchval && $listsels[$index] =~ /^\Q$srchval\E/i)
		{
			$l->selectionClear('0','end');
			$l->activate($index);
			$l->selectionSet($index);
			$l->update();
			$l->see($index);
			return -1;
		}
	}
	return 0;
}

sub LbIndex
{
	my ($w, $flag) = @_;
	my $sel = $w->Subwidget("slistbox")->Subwidget("listbox")->curselection 
		|| $w->Subwidget("slistbox")->Subwidget("listbox")->index('active');
	$sel = $w->Subwidget("slistbox")->Subwidget("listbox")->index('active')
			unless ($sel =~ /^\d+$/);   #JWT:  ADDED 20040819 'CAUSE CURSELECTION SEEMS TO RETURN "ARRAY(XXXX)" NOW?!?!?!
	if (defined $sel)
	{
		return int($sel);
	}
	else
	{
		if (defined $flag && ($flag eq "emptyOK"))
		{
			return undef;
		}
		else
		{
			return 0;
		}
	}
}

# POP DOWN THE LISTBOX

sub Popdown
{
	my ($w, $flag) = @_;
	my ($state) = $w->cget( "-state" );
	if ($w->{"popped"})
	{
		my $c = $w->Subwidget("choices");
		$c->withdraw;
		$w->grabRelease;
		$w->{"popped"} = 0;
		########$w->Subwidget("entry")->focus; #  unless ($flag);
		$w->Subwidget("entry")->selectionRange(0,'end')  
				unless ($w->{-noselecttext} || !$w->Subwidget("entry")->index('end'));
	}

	if ($w->{'savefocus'} && Tk::Exists($w->{'savefocus'}))
	{
		$w->{'savefocus'}->focus;
		#delete $w->{'savefocus'};
	}
	else
	{
		$w->Subwidget("entry")->focus; #  unless ($flag);
	}
}

# THIS HACK IS TO PREVENT THE UGLINESS OF THE ARROW BEING DEPRESSED.

sub ButtonHack
{
	my ($w) = @_;
	my $b = $w->Subwidget("arrow");

#JWT: NEXT 6 LINES ADDED TO UNPOP MENU IF BUTTON PRESSED OUTSIDE OF LISTBOX.

	my $s = $w->Subwidget("slistbox");
	my $e = $s->XEvent;
	unless (defined($e))
	{
		$w->LbClose;
	}

	if ($w->{"buttonHack"})
	{
		$b->butUp;
	}
}

sub choices
{
	my $w = shift;
	unless( @_ )   #NO ARGS, RETURN CURRENT CHOICES.
	{
		return( $w->get( qw/0 end/ ) );
	}
	else           #POPULATE DROPDOWN LIST WITH THESE CHOICES.
	{
		my $choices = shift;
		if ($choices)
		{
			$w->delete( qw/0 end/ );
			$w->{hashref} = {}  if (defined $w->{hashref});   #ADDED 20050125.
			$w->insert($choices);
		}

		#NO WIDTH SPECIFIED, CALCULATE TEXT & LIST WIDTH BASED ON LONGEST CHOICE.

		unless ($w->{-listwidth})
		{
			my @l = $w->Subwidget("slistbox")->get(0, 'end');
			my $width = 0;
			for (my $i=0;$i<=$#l;$i++)
			{
				$width = length($l[$i])  if ($width < length($l[$i]));
			}
			$width = $w->{-maxwidth}  if ($width > $w->{-maxwidth} && $w->{-maxwidth} > 0);
			$w->Subwidget("entry")->configure(-width => $width);
			$w->Subwidget("choices")->configure(-width => $width);
			$w->Subwidget("slistbox")->configure(-width => $width);
		}
		$w->state($w->cget(-state));
		return( "" );
	}
}

# INSERT NEW ITEMS INTO DROPDOWN LIST.

sub insert
{
	my $w = shift;
	my ($pos);
	if ($_[1])
	{
		$pos = shift;
	}
	else
	{
		$pos = 'end';
	}
	#my $pos = shift || 'end';    #POSITION IN LIST TO INSERT.
	my $item = shift;            #POINTER TO OR LIST OF ITEMS TO INSERT.
	my $res;
	if (ref($item))
	{
		if (ref($item)  eq 'HASH')
		{
			my @choiceKeys = ();
			@choiceKeys = sort { $item->{$a} cmp $item->{$b} } keys(%$item);
			my @choiceVals = sort values(%$item);
			$w->Subwidget('slistbox')->insert($pos, @choiceVals);
			my $choiceReverseHashRef = (defined $w->{hashref}) ? $w->{hashref}
					: {};    #ADDED 20050125.
			for (my $i=0;$i<=$#choiceKeys;$i++)   #ADDED 20050125.
			{
				$choiceReverseHashRef->{$choiceVals[$i]} = $choiceKeys[$i];
			}
			$w->{hashref} = $choiceReverseHashRef;
		}
		else
		{
			$res = $w->Subwidget("slistbox")->insert($pos, @$item);
		}
	}
	else
	{
		$res = $w->Subwidget("slistbox")->insert($pos, $item, @_);
	}

	#NO WIDTH SPECIFIED, (RE)CALCULATE TEXT & LIST WIDTH BASED ON LONGEST CHOICE.

	unless ($w->{-listwidth})
	{
		my @l = $w->Subwidget("slistbox")->get(0, 'end');
		my $width = 0;
		for (my $i=0;$i<=$#l;$i++)
		{
			$width = length($l[$i])  if ($width < length($l[$i]));
		}
		$width = $w->{-maxwidth}  if ($width > $w->{-maxwidth} && $w->{-maxwidth} > 0);
		$w->Subwidget("entry")->configure(-width => $width);
		$w->Subwidget("choices")->configure(-width => $width);
		$w->Subwidget("slistbox")->configure(-width => $width);
	}
	$w->state($w->state());
	return $res;
}

sub delete
{
	my $w = shift;
	my $res = $w->Subwidget("slistbox")->delete(@_);
	if (defined $w->{hashref})   #ADDED 20050125.
	{
		foreach my $i (@_)
		{
			delete $w->{hashref}->{$i}  if (defined $w->{hashref}->{$i});
		}
	}
	unless ($w->Subwidget("slistbox")->size > 0)
	{
		my $button = $w->Subwidget( "arrow" );
		$button->configure( -state => "disabled", -takefocus => 0);
	}
	return $res;
}

sub curselection  #RETURN CURRENT LISTBOX SELECTION.
{
	return shift->Subwidget("slistbox")->curselection;
}

# CHANGE APPEARANCES BASED ON CHANGES IN "-STATE" OPTION.

sub _set_edit_state
{
	my( $w, $state ) = @_;
	$state ||= 'normal';      #JWT: HAD TO ADD THIS IN TK804...
	my $entry  = $w->Subwidget( "entry" );
	my $frame  = $w->Subwidget( "frame" );
	my $button = $w->Subwidget( "arrow" );
	my ($color, $txtcolor, $framehlcolor, $texthlcolor);  # MAKE ENTRY FIELDS LOOK WINDOSEY!

	unless ($w->{-background})
	{
		if ($^O =~ /Win/i)   # SET BACKGROUND TO WINDOWS DEFAULTS (IF NOT SPECIFIED)
		{
			#if ($state eq 'disabled' || $state eq 'readonly')
			if ($state eq 'disabled')
			{
				$color = "SystemButtonFace";
			}
			else
			{# Not Editable
				$color = $w->cget( -background );
				$color = 'SystemWindow'  if ($color eq 'SystemButtonFace');
			}
			$entry->configure( -background => $color );
		}
		else   #UNIX.
		{
			#THIS APPEARS TO FORCE THE TEXT BACKGROUND TO GREY, IF THE PALETTE 
			#IS SOMETHING ELSE BUT USER HAS NOT SPECIFIED A BACKGROUND.
			if ($w->cget( "-colorstate" ))  #NOT SURE WHAT POINT OF THIS IS.
			{
				if( $state eq "normal" || $state =~ /text/ )
				{# Editable
					$color = "gray95";
				}
				else
				{# Not Editable
					$color = $w->cget( -background ) || "lightgray";
				}
				$entry->configure( -background => $color);
			}
		}
	}

	$txtcolor = $w->{-foreground} || $w->cget( -foreground )  unless ($state eq "disabled");
	$texthlcolor = $w->{-background} || $entry->cget( -background );
	$framehlcolor = $w->{-foreground} || $entry->cget( -foreground );
	if( $state eq "readonly" )
	{
		$framehlcolor = $w->{-foreground} || $entry->cget( -foreground );
		$entry->configure( -state => "disabled", -takefocus => 0, 
				-foreground => $txtcolor, -highlightcolor => $texthlcolor);
		if ($^O =~ /Win/i)
		{
			$button->configure( -state => "normal", -takefocus => $w->{btntakesfocus}, -relief => 'raised');
			$frame->configure(-relief => ($w->{-relief} || 'groove'), 
					-takefocus => (1 & $w->{takefocus}), -highlightcolor => $framehlcolor);
		}
		else
		{
			$button->configure( -state => "normal", -takefocus => $w->{btntakesfocus}, -relief => 'raised');
			$frame->configure(-relief => ($w->{-relief} || 'raised'), 
					-takefocus => (1 & $w->{takefocus}), -highlightcolor => $framehlcolor);
		}
	}
	elsif ($state =~ /text/ )
	{
		$framehlcolor = $w->{-background} || 'SystemButtonFace'
				if ($^O =~ /Win/i);
		$button->configure( -state => "disabled", -takefocus => 0, 
				-relief => 'flat');
		$frame->configure(-relief => ($w->{-relief} || 'sunken'), 
				-takefocus => 0, -highlightcolor => $framehlcolor);
		$entry->configure( -state => 'normal', 
				-takefocus => (1 & ($w->{takefocus} || $w->{btntakesfocus})), 
				-foreground => $txtcolor, -highlightcolor => $texthlcolor);
	}
	elsif ($state eq "disabled" )
	{
		$entry->configure( -state => "disabled", -takefocus => 0, 
				-foreground => ($button->cget('-disabledforeground')||'gray30'), -highlightcolor => $texthlcolor);
				#-foreground => 'gray30', -highlightcolor => $texthlcolor);
		if ($^O =~ /Win/i)
		{
			$framehlcolor = $w->{-background} || 'SystemButtonFace';
			$button->configure(-state => "disabled",  -takefocus => 0, 
					-relief => 'flat');
			$frame->configure(-relief => ($w->{-relief} || 'sunken'), 
					-takefocus => 0, -highlightcolor => $framehlcolor);
		}
		else
		{
			$frame->configure(-relief => ($w->{-relief} || 'groove'), 
					-takefocus => 0, -highlightcolor => $framehlcolor);
		}
		$button->configure(-state => "disabled",  -takefocus => 0, 
				-relief => 'raised');
	}
	else   #NORMAL.
	{
		$framehlcolor = $w->{-background} || 'SystemButtonFace'
				if ($^O =~ /Win/i);
		#$entry->configure( -state => $state, -takefocus => (1 & $w->{takefocus}), 
		$entry->configure( -state => $state, -takefocus => 0, 
				-foreground => $txtcolor, -highlightcolor => $texthlcolor);
		$button->configure( -state => $state, -relief => 'raised', 
				-takefocus => $w->{btntakesfocus});
		$frame->configure(-relief => ($w->{-relief} || 'sunken'), 
				-takefocus => (1 & $w->{takefocus}), 
				-highlightcolor => $framehlcolor);
	}
	$entry->configure( -background => $w->{-textbackground})  if ($w->{-textbackground});
	$entry->configure( -foreground => $w->{-textforeground})  if ($w->{-textforeground});
	unless ($w->Subwidget("slistbox")->size > 0)
	{
		$button->configure( -state => "disabled", -takefocus => 0);
	}
}

sub state
{
	my $w = shift;
	unless( @_ )
	{
		return( $w->{Configure}{-state} );
	}
	else
	{
		my $state = shift;
		$w->{Configure}{-state} = $state;
		$w->_set_edit_state( $state );
	}
}

sub _max
{
	my $max = shift;
	foreach my $val (@_)
	{
		$max = $val if $max < $val;
	}
	return( $max );
}

sub dereference   #USER-CALLABLE FUNCTION, ADDED 20050125.
{
	my $w = shift;
	return undef  unless (defined $_[0]);
	my $userValue = shift;
	return (defined($w->{hashref}) && defined($w->{hashref}->{$userValue}))
			? $w->{hashref}->{$userValue} : $userValue;
}

sub dereferenceOnly   #USER-CALLABLE FUNCTION, ADDED 20050125.
{
	my $w = shift;
	return undef  unless (defined $_[0]);
	my $userValue = shift;
	return (defined($w->{hashref}) && defined($w->{hashref}->{$userValue}))
			? $w->{hashref}->{$userValue} : undef;
}

sub hasreference   #USER-CALLABLE FUNCTION, ADDED 20050125.
{
	my $w = shift;
	return undef  unless (defined $_[0]);
	my $userValue = shift;
	return (defined($w->{hashref}) && defined($w->{hashref}->{$userValue}))
			? 1 : undef;
}

sub fetchhash
{
	my $w = shift;
	return (defined $w->{hashref}) ? $w->{hashref} : undef;
}

1;

__END__

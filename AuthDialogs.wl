(* ::Package:: *)

(* ::Section:: *)
(*AuthDialogs*)


(* ::Text:: *)
(*Direct copy of one of my BTools packages. Interface is pretty bad.*)


BeginPackage["AuthDialogs`"];


BannerDialog::usage=
	"Generate a dialog with a banner";
BannerDialogInput::usage=
	"Generates a dialog for with a banner";


AuthenticationDialog::usage=
	"Generates an authentication dialog";
PasswordDialog::usage=
	"A raw password dialog";
OAuthDialog::usage=
	"Uses AuthenticationDialog to generate an OAuth dialog";


Begin["`Private`"];


Options[BannerDialogConfig]=
	Join[
		Options[DialogInput],{
		Appearance->Automatic
		}];
BannerDialogConfig[
	banner_,
	content_,
	submit:_Button|Automatic:Automatic,
	cancel:_Button|Automatic:Automatic,
	ops:OptionsPattern[]
	]:=
		{
			{
				ExpressionCell[#,
					CellFrameMargins->None,
					CellMargins->8]&@
					With[{
						size=
							Replace[OptionValue[WindowSize],{
								{w_,h_}:>
									{
										Replace[w,
											Automatic->400
											],
										Replace[h,
											Automatic->450
											]-110
										},
								w_Integer:>
									{w,340},
								Automatic:>
									{400,340}
								}]
						},
						Pane[
							content,
							ImageSize->
								size,
							BaseStyle->"Output",
							Scrollbars->Automatic
							]
						],
				ExpressionCell[#,
					"Output",
					Background->GrayLevel[.98],
					CellFrameColor->GrayLevel[.8],
					CellFrame->{{0,0},{0,1}},
					CellMargins->0,
					CellTags->{"FooterCell"}
					]&@
					Pane[
						Row@
							{
								With[{
									s=
										Replace[submit,
											Automatic:>
												Button["Submit",DialogReturn[True]]
											]
									},
									(*ExpressionCell[#,
										CellTags\[Rule]"Return",
										CellMargins\[Rule]0,
										CellFrameMargins\[Rule]0
										]&@*)
									Button[
										Style[First@s,
											Replace[OptionValue@Appearance,{
												c_?ColorQ:>
													If[ColorDistance[c,Black,DistanceFunction->"DeltaL"]>.7,
														Black,
														White
														],
												_->White
												}]
											],
										s[[2]];DialogReturn[],
										ImageSize->{100,30},
										Appearance->
											Replace[
												Replace[OptionValue@Appearance,{
													c_?ColorQ:>
														GradientButtonAppearance[
															{c,c,
																Replace[ColorConvert[c,Hue],
																	Hue[h_,s_,b_]:>
																		Hue[h,s,b*1.1]
																	]
																}
															],
													"OAuth"->
														{"Default"->Image[CompressedData["
1:eJxTTMoPSmNiYGAo5gASQYnljkVFiZXBAkBOaF5xZnpeaopnXklqemqRRRIz
UFAGiHmBmIUBBfwngFFAmrHxf2Ixsp6Zvr4E8TDW859EPf+Hgp5ZQDFCGF3P
HD8/ghhdz1x/f4IYXc98oBghjK5nYUAAQYyuZ1FgIEGMrmdJUBBBjK5nWXAw
QYyuZ3lICEGMrmcFUIwQplAPA4l6GIaCHhLLREJlLkYZDAA7N6DO
"], "Byte", ColorSpace -> "RGB", Interleaving -> True],"Hover"->Image[CompressedData["
1:eJzd1DEKwkAQheFBLWwED5DGW9haSrqIB0hwDTZrsruJeCgjiop6uXVKMxbP
xSou/IE8+NqZZNtk3SMiO+RPku5mxqT7xZh/ltpucq1Wc+1Ursw06/MYcSNu
QK3nQa3n4th/27s5FAXsj40PNL4LpilLmDRH3lDSnIyBSXO2FibNhTeUNFfn
YNLcqgomzZ03lDSPuoZJ8+QN9aOhQENdMIE3Ed3cjxv8AkYm/IA=
"], "Byte", ColorSpace -> "RGB", Interleaving -> True],"Pressed"->Image[CompressedData["
1:eJxTTMoPSmNiYGAo5gASQYnljkVFiZXBAkBOaF5xZnpeaopnXklqemqRRRIz
UFAGiHmBmIUBBfwngFFAjJ7ef2Ixsp5aOzuCeBjr+U+inv9012NvTxCj62lw
cCCI0fU0OzoSxOh6Wp2dCWJ0PR0uLgQxup5uV1eCGF1Pr7s7QYyuZ4KHB0GM
rmeylxdBjK5nmrc3QYyuZ7qPD0FMoR4GEvUwDAU9JJaJhMpcjDIYAHUsdEc=

"], "Byte", ColorSpace -> "RGB", Interleaving -> True]},
													"Password"->
														{"Default"->Image[CompressedData["
1:eJxTTMoPSmNiYGAo5gASQYnljkVFiZXBAkBOaF5xZnpeaopnXklqemqRRRIz
UFAGiHmBmIUBBfwngFGAa5rtf2Ixsp6MmTEE8TDW859EPf+Hgp7MWTEEMbqe
rDmxBDG6nuy5cQQxup6c+fEEMbqe3IUJBDG6nrxFiQQxup6CJUkEMbqewmXJ
BDG6nqLlKQQxhp4VqQQxhXoYSNTDMBT0kFgmEipzMcpgALzlzcw=
"], "Byte", ColorSpace -> "RGB", Interleaving -> True],"Hover"->Image[CompressedData["
1:eJxTTMoPSmNiYGAo5gASQYnljkVFiZXBAkBOaF5xZnpeaopnXklqemqRRRIz
UFAGiHmBmIUBBfwngFFAZEnwf2Ixsp62tTUE8TDW859EPf+Hgp72dbUEMbqe
jvV1BDG6ns6NdQQxhp5N9QQxup6uLQ0EMbqe7q2NBDG6np5tTQQxup7eHc0E
Mbqevp3NBDG6nv5dLQQxhXoYSNTDMBT0kFgmEipzMcpgAEESIOE=
"], "Byte", ColorSpace -> "RGB", Interleaving -> True],"Pressed"->Image[CompressedData["
1:eJxTTMoPSmNiYGAo5gASQYnljkVFiZXBAkBOaF5xZnpeaopnXklqemqRRRIz
UFAGiHmBmIUBBfwngFGAXYz5f2Ixsp7QWm+CeBjr+U+inv9DQU94gy9BjK4n
stmPIEbXE90aQBCj64npCCKI0fXEdQcTxOh6EnpDCWJ0PUkTwglidD0pkyMI
YnQ9adOiCGJ0PenTowliCvUwkKiHYSjoIbFMJFTmYpTBADDZm5A=
"], "Byte", ColorSpace -> "RGB", Interleaving -> True]},
													_:>
														{"Default"->Image[CompressedData["
1:eJxTTMoPSmNiYGAo5gASQYnljkVFiZXBAkBOaF5xZnpeaopnXklqemqRRRIz
UFAGiHmBmIUBBfwngFGBTv5/ojGyHqdlhPHw1fOfRD3/h4Qe5+WEMboel1WE
Mboe17WEMboetw2EMboe982EMboez62EMboerx2EMboe792EMboen32EMboe
3/2EMWV6GEjUwzAk9JBWJhIqczHKYAD7oFbD
"], "Byte", ColorSpace -> "RGB", Interleaving -> True],"Hover"->Image[CompressedData["
1:eJxTTMoPSmNiYGAo5gASQYnljkVFiZXBAkBOaF5xZnpeaopnXklqemqRRRIz
UFAGiHmBmIUBBfwngFGAkmvVf2Ixsh7jjB0E8TDW859EPf+Hhp6dBDGGnszd
BDGGnqy9BDGGnuwDBDGGnpxDBDGGntwjBDGGnrxjBDGGnvyTBDGGnoLTBDGm
njMEMYV6GEjUwzAU9JBYJhIqczHKYAATccEy
"], "Byte", ColorSpace -> "RGB", Interleaving -> True],"Pressed"->Image[CompressedData["
1:eJxTTMoPSmNiYGAo5gASQYnljkVFiZXBAkBOaF5xZnpeaopnXklqemqRRRIz
UFAGiHmBmIUBBfwngFGBRvJ/ojGyHvMOwnj46vlPop7/9NfTSRij67HoJozR
9Vj2EcboeqwmEsboeqwnE8boemymE8boeuxmE8boehwWEMboepyWEsboelxW
EcboelzXEMaU6WEgUQ/DkNBDWplIqMzFKIMBfRg0Sw==
"], "Byte", ColorSpace -> "RGB", Interleaving -> True]}
													}
												],
											l_List:>
												Append[l,"ButtonType" -> "Default"]
											]
										]
									],
								Spacer[{10,0}],
								With[{
									c=
										Replace[cancel,
											Automatic:>
												Button["Cancel",DialogReturn[$Canceled]]
											]
									},
									Button[
										First@c,
										c[[2]];
										DialogReturn[$Canceled],
										ImageSize->{100,30},
										Appearance->
											{
												"Default"->Image[CompressedData["
1:eJzV1EEKgkAYhuGhWrQJOkCbbtG2ZduiAyhZtDGwIDqKRxNFUVFEEVF0bUMU
5NfiS1r1wzvMDDzbf66e1vuBEOI8lsdauS4NQ7ltpvKx1c/Hg67tVvpFO2jG
Qh3Kz5lsIhuJzrSkzpim2X7bu7Esi4bGtm0aGsdxaGhc16Wh8TyP9mYed9/3
aU/TvkwQBDQ0YRjS0ERRREMTxzENTZIkNDRpmtLQZFlGQ5PnOQ1NURQ0NGVZ
0tBUVUVDU9c1DU3TNLQfjehpxD+YnjuR7dyPHXwHy1co2w==
"], "Byte", ColorSpace -> "RGB", Interleaving -> True],
												"Hover"->Image[CompressedData["
1:eJzV1E0KgkAYxvGhWrQJOkCbbtG2ZduiAyhZtDGwIDqKx/MDP1FRUZc2REE+
LZ6kVS/8h5mB3/adq6f1fiCEOI/lsVauS8NQbpupfGz18/Gga7uVftEOmrFQ
h/JzJpvIRqIzLakzpmm23/ZuLMuiobFtm4bGcRwaGtd1aWg8z6O9mcfd933a
07QvEwQBDU0YhjQ0URTR0MRxTEOTJAkNTZqmNDRZltHQ5HlOQ1MUBQ1NWZY0
NFVV0dDUdU1D0zQN7UcjehrxD6bnTmQ792MH3wFFhzOd
"], "Byte", ColorSpace -> "RGB", Interleaving -> True],
												"Pressed"->Image[CompressedData["
1:eJxTTMoPSmNiYGAo5gASQYnljkVFiZXBAkBOaF5xZnpeaopnXklqemqRRRIz
UFAGiHmBmIUBBfwngFHAzJkz/xOLkfVs27aNIB7Gev6TqOc/vfVs376dIEbX
s2fPHoIYXc/BgwcJYnQ9x44dI4jR9Zw+fZogRtdz/vx5ghhdz6VLlwhidD1X
r14liNH13LhxgyBG13P79m2CGF3PnTt3CGIK9TCQqIdhKOghsUwkVOZilMEA
mEXTyg==
"], "Byte", ColorSpace -> "RGB", Interleaving -> True],
												"ButtonType" -> "Cancel"
												}
										]
									]
								},
						ImageSize->
							Replace[OptionValue[WindowSize],{
								{w_,h_}:>
									{Replace[w,Automatic|Fit->400],100-70},
								w_Integer:>
									{w,100-70},
								_->
									{400,100-70}
								}],
						Alignment->{Left,Center}
						]
					},
		WindowSize->
			Replace[OptionValue@WindowSize,{
				{w_,h_}:>
					{
						Replace[w,Automatic->400],
						Replace[h,Automatic->450]
						},
				w_Integer:>
					{w,450},
				_->{400,450}
				}],
		Sequence@@
			FilterRules[{
				ops
				},
				Options@DialogInput
				],
		DockedCells->
			Cell[
				BoxData@ToBoxes@
					Pane[
						If[StringQ@banner,RawBoxes@banner,banner],
						{Scaled[.7],30},
						Alignment->{Center,Center},
						ImageSizeAction->"ResizeToFit"
						],
				"Panel",
				FontFamily->"Times",
				FontColor->
					Replace[OptionValue[Appearance],{
						c_?ColorQ:>
							Replace[ColorConvert[c,Hue],
								Hue[h_,_,b_]:>
									If[b>.7,
										Hue[h,.1,.2],
										Hue[h,.05,.95]
										]
								],
						"OAuth"->
							Hue[0,.03,.95],
						"Password"->
							Hue[.3,.03,.95],
						_->Hue[.6,.05,.95]
						}],
				TextAlignment->Center,
				Background->
					Replace[OptionValue[Appearance],{
						c_?ColorQ:>
							c,
						"OAuth"->
							Hue[0,.5,.6],
						"Password"->
							Hue[.3,.4,.6],
						_->
							Hue[.6,1,.65]
						}],
				CellFrame->{{0,0},{1,0}}
				],
		NotebookDynamicExpression :>
			Refresh[
				FrontEnd`MoveCursorToInputField[
					EvaluationNotebook[], 
					"password"
					];
				FrontEnd`MoveCursorToInputField[
					EvaluationNotebook[], 
					"username"
					];,
				None
			],
		WindowFrameElements->{"CloseBox"},
		WindowElements->None,
		WindowTitle->"",
		Background->White,
		ImageMargins->0,
		CellMargins->0
		};


Options[BannerDialog]=
	Options@BannerDialogConfig;
BannerDialog[
	banner_:"",
	content_,
	submit:Button[_,__]|Automatic:Automatic,
	cancel:Button[_,__]|Automatic:Automatic,
	ops:OptionsPattern[]
	]:=
		CreateDialog@@
			BannerDialogConfig[banner,content,submit,cancel,ops]


Options[BannerDialogInput]=
	Options@BannerDialogConfig;
BannerDialogInput[
	vars:{(_Symbol|_Set|_SetDelayed)...}|None:None,
	banner_:"",
	content_,
	submit:Button[_,__]|Automatic:Automatic,
	cancel:Button[_,__]|Automatic:Automatic,
	ops:OptionsPattern[]
	]:=
	If[Unevaluated[vars]===None,
		DialogInput[#,##2]&,
		DialogInput[vars,Column@#,##2]&
		]@@
		BannerDialogConfig[banner,content,submit,cancel,ops];
BannerDialogInput~SetAttributes~HoldFirst


authUserNameField[Verbatim[Dynamic][var_],site_,default_]:=
	InputField[
		var[site]=
			Replace[var[site],{
				{v:Except[""],p_}:>
					{v,p},
				{"",p_}:>
					{default,p},
				_->{default,""}
				}];
		Dynamic[
			Replace[var[site],{
				{u_,_}:>u,
				_->default
				}],
			var[site]=
				Replace[var[site],{
					{_,p_}:>
						{#,p},
					_->{#,""}
					}];&
			],
		String,
		BoxID->"username"
		];


authPasswordField[Verbatim[Dynamic][var_],site_,default_]:=
	InputField[
		var[site]=
			Replace[var[site],{
				{v_,p:Except[""]}:>
					{v,p},
				{v_,""}:>
					{v,default},
				_->{"",default}
				}];
		Dynamic[
			Replace[var[site],{
				{_,p_}:>p,
				_->default
				}],
			var[site]=
	Replace[var[site],{
					{u_,_}:>
						{u,#},
					_->{default,#}
					}];&
			],
		String,
		FieldMasked->$authDialogFieldMasked,
		BoxID->"password"
		];


authDialogFields[var_,
	site:_String|{_String,_},
	username:_String|None|{_String,_}:"",
	password:_String|None|{_String,_}:""]:=
	{
		{
			If[StringQ@site||Last@site===Automatic,
				Style["Enter the password for ``:"~TemplateApply~site,GrayLevel[.2]],
				Last@site
				],
			SpanFromLeft
			},
		If[username=!=None,
			DeleteCases[None]@{
				If[StringQ@username||Last@site===Automatic,
					Style["Username:",GrayLevel[.5]],
					Last@username
					],
				authUserNameField[var,
					Replace[site,{s_,_}:>s],
					Replace[username,
						{u_,_}:>u
						]
					]
				},
			{}
			],
		If[password=!=None,
			DeleteCases[None]@{
				If[StringQ@password||Last@site===Automatic,
					Style["Password:",GrayLevel[.5]],
					Last@password
					],
				authPasswordField[var,
					Replace[site,{s_,_}:>s],
					Replace[password,
						{p_,_}:>p
						]]
				},
			{}
			]
		};
authDialogFields[var_,
	{site:_String|{_String,_}}]:=
	authDialogFields[var,site];
authDialogFields[var_,
	{site:_String|{_String,_},
		username:_String|None|{_String,_}
		}
	]:=
	authDialogFields[var,site,username];
authDialogFields[var_,
	{site:_String|{_String,_},
		username:_String|None|{_String,_},
		password:_String|None|{_String,_}}]:=
	authDialogFields[var,site,username,password];


SetAttributes[#,
	{
		HoldFirst
		}
	]&/@{
		authDialogFields,
		authPasswordField,
		authUserNameField
		};


Options[AuthenticationDialog]=
	Join[
		Options@BannerDialogConfig,{
		FieldMasked->True
		}];
AuthenticationDialog[
	var:Verbatim[Dynamic][_Symbol]:Dynamic[None],
	banner_:"Authentication Credentials",
	header_:None,
	specs:(
		_String|{_String|{_String,_}}|
		{_String|{_String,_},_String|None|{_String,_}}|
		{_String|{_String,_},_String|None|{_String,_},_String|None|{_String,_}}
		)..,
	ops:OptionsPattern[]
	]:=
	If[MatchQ[var,Verbatim[Dynamic][None]],
		Clear@$AuthenticationCache;
		(Clear@$AuthenticationCache;#)&@
		AuthenticationDialog[Dynamic[$AuthenticationCache],
			banner,
			header,
			specs,
			ops],
		BannerDialogInput[
			None,
			If[!AssociationQ@First@var,
				Replace[var,
					Verbatim[Dynamic][v_]:>
						Set[v,<||>]
					]
				];
			banner,
			If[header=!=None,
				Column@{header,#}&,
				Identity]@
				Block[{$authDialogFieldMasked=TrueQ@OptionValue[FieldMasked]},
					Grid[
						Join@@
							Map[
								Function[Null,
									authDialogFields[var,#],
									HoldFirst],
								DeleteDuplicatesBy[{specs},
									Replace[{
										{s_String,___}:>s,
										{{s_String,_},___}:>s
										}]
									]
								],
						Dividers->{None,{None,{None,None,GrayLevel[.8]},None}},
						Spacings->{Automatic,{0,{.5,.5,1},0}},
						Alignment->Left
						]
				],
			Button[
				"Submit",
				DialogReturn[First@var]
				],
			Button[
				"Cancel",
				DialogReturn[$Canceled]
				],
			FilterRules[{ops},
				Options@BannerDialogConfig
				],
			WindowTitle->"Authenticate",
			WindowSize->
				If[Length@{specs}>1,
					Automatic,
					{350,300}
					],
			WindowFrame->"MovableModalDialog",
			CellContext->$Context
			]
		];


Options[PasswordDialog]=
	Append[
		Options[AuthenticationDialog],
		"PromptString"->"Input the password for ``:"
		];
PasswordDialog[
	var:Verbatim[Dynamic][_Symbol]:Dynamic[None],
	banner_:"",
	spec_String,
	ops:OptionsPattern[]
	]:=
	If[MatchQ[var,Verbatim[Dynamic][None]],
		Clear@$PasswordCache;
		(Clear@$PasswordCache;#)&@
		PasswordDialog[Dynamic@$PasswordCache,
			banner,
			spec,
			ops
			],
		Replace[
			a_Association:>
				Replace[a[spec],{
					_Missing->None,
					{_,p_String}:>
						p
					}]
			]@
			AuthenticationDialog[var,
				banner,
				OptionValue["PromptString"]~TemplateApply~spec,
				{{spec,Null},None,{"",None}},
				Evaluate@
					FilterRules[{
						ops,
						Appearance->"Password",
						WindowTitle->"Input Password"
						},
						Options@AuthenticationDialog
						]
				]
		]


Options[OAuthDialog]=
	Options[AuthenticationDialog];
OAuthDialog[
	var:Verbatim[Dynamic][_Symbol]:Dynamic[None],
	banner_:"OAuth",
	header:_String?(URLParse[#,"Scheme"]=!=None&)|Except[_String]:None,
	spec:_String|{_String,_String},
	ops:OptionsPattern[]
	]:=
	If[MatchQ[var,Verbatim[Dynamic][None]],
		Clear@$OAuthCache;
		(Clear@$OAuthCache;#)&@
		OAuthDialog[Dynamic@$OAuthCache,
			banner,
			header,
			spec,
			ops
			],
		Replace[
			a_Association:>
				Replace[a[First@Flatten@{spec}],{
					_Missing->None,
					{u_String,p_String}:>
						If[StringQ@spec,
							p,
							{u,p}
							]
					}]
			]@
			AuthenticationDialog[var,
				banner,
				Replace[header,{
					s_String:>
						Row@{
							"Go to the ",
							Hyperlink["OAuth Site",s]
							},
					{s_String,example:Except[_String]}:>
						Column@{
							Row@{
								"Go to the ",
								Hyperlink["OAuth Site",s]
								},
							Mouseover[
								Style["Trouble finding the key?","Message"],
								If[ImageQ@example,
									Image[example,ImageSize->325],
									Pane[example,
										ImageSize->325,
										ImageSizeAction->"ShrinkToFit"
										]
									],
								ImageSize->All
								]
							},
					{label_,link_String}:>
						Row@{
							"Go to ",
							Hyperlink[label,link]
							},
					{{label_,link_},example_}:>
						Column@{
							Row@{
								"Go to ",
								Hyperlink[label,link]
								},
							Mouseover[
								Style["Trouble finding the key?","Message"],
								If[ImageQ@example,
									Image[example,ImageSize->325],
									Pane[example,
										ImageSize->325,
										ImageSizeAction->"ShrinkToFit"
										]
									],
								ImageSize->All
								]
							}
					}],
				Replace[spec,{
					site_String:>
						{
							{site,Null},
							None,
							{"",None}
							},
					{site_,uname_}:>
						{
							{site,Null},
							uname,
							{"",None}
							}
					}],
				ops,
				Appearance->"OAuth",
				WindowTitle->"OAuth",
				FieldMasked->False
				]
		]


(* ::Subsection:: *)
(*End*)


End[];


EndPackage[]

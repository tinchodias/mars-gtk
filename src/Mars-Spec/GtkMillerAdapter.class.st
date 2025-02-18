Class {
	#name : #GtkMillerAdapter,
	#superclass : #GtkLayoutAdapter,
	#instVars : [
		'layout',
		'innerWidget',
		'lastExtent',
		'lastPageSize'
	],
	#category : #'Mars-Spec-Layout-Box'
}

{ #category : #protocol }
GtkMillerAdapter >> add: aPresenter [

	self add: aPresenter constraints: SpLayoutConstraints new
]

{ #category : #private }
GtkMillerAdapter >> add: aPresenter constraints: constraints [
	| childWidget |
	
	self widget ifNil: [ ^ self ].
 
	childWidget := self 
		basicAdd: aPresenter 
		constraints: constraints 
		to: innerWidget.
	"I'm keeping a reference to aPresenter into the built widget because in some cases 
	 it can be GC (in case of the on-the-fly creation, for example). 
	 Now this can be a real bad idea :)"
	childWidget data: aPresenter.
	self recalculatePages.
	self scrollToShowLastPage
]

{ #category : #private }
GtkMillerAdapter >> addConstraits: constraints toChild: childWidget [
	"adds constraits by child."
	
	^ childWidget
]

{ #category : #private }
GtkMillerAdapter >> basicAdd: aPresenter constraints: constraints to: gtkWidget [
	| childWidget |

	childWidget := aPresenter buildWithSpec: constraints spec.
	self addConstraits: constraints toChild: childWidget.
	gtkWidget 
		packStart: childWidget 
		expand: true
		fill: true
		padding: 0.
			
	^ gtkWidget
]

{ #category : #building }
GtkMillerAdapter >> buildWidget [
	"We defer this until layout: (because then I will know what I have to create)"
	
	^ nil
]

{ #category : #private }
GtkMillerAdapter >> childrenWidgets [
	
	^ innerWidget children
]

{ #category : #private }
GtkMillerAdapter >> doScrollToShowLastPage [
	| lastWidget pos |

	lastWidget := innerWidget children last.
	pos := lastWidget 
		translateCoordinates: 0@0 
		to: innerWidget.
	pos = (-1@ -1) ifTrue: [ 
		"reschedule to be sure is executed"
		^ self scrollToShowLastPage ].
	
	self widget hAdjustment value: pos x.
	self widget vAdjustment value: pos y
]

{ #category : #building }
GtkMillerAdapter >> layout: aLayout [

	layout := aLayout.
	
	"build of widget was differed up to here (to know what is the direction)"
	innerWidget := layout direction newWidgetOn: self.

	innerWidget 
		homogeneous: true;
		spacing: aLayout spacing;
		borderWidth: aLayout borderWidth;
		show.
		
	widget := GtkScrolledWindow newWidget: innerWidget.
	widget connectSizeAllocate: [ :aRect | self recalculatePages ].
		
	self toggleVisible: model isVisible.
	model whenVisibleChangedDo: [ 	
		self toggleVisible: model isVisible ] .

	
]

{ #category : #factory }
GtkMillerAdapter >> newHorizontal [

	^ GtkBox newHorizontal
]

{ #category : #factory }
GtkMillerAdapter >> newVertical [

	^ GtkBox newVertical
]

{ #category : #private }
GtkMillerAdapter >> recalculatePageHeights [
	| newHeight widgets height |

	height := self widget height.
	widgets := self childrenWidgets.
	newHeight := widgets size = 1
		ifTrue: [ height ]
		ifFalse: [ height / (layout visiblePages min: widgets size) - (layout spacing / (layout visiblePages min: widgets size)) ].
		
	"since the container box is homogeneous, I just need to change the size of 
	 first element to get all the rest to follow"
	widgets first sizeRequest: (widgets first preferredSizeMinimum x)@newHeight
]

{ #category : #private }
GtkMillerAdapter >> recalculatePageWidths [
	| newWidth widgets width |

	width := self widget width.
	widgets := self childrenWidgets.
	newWidth := widgets size = 1
		ifTrue: [ width ]
		ifFalse: [ width / (layout visiblePages min: widgets size) - (layout spacing / (layout visiblePages min: widgets size)) ].
	
	"since the container box is homogeneous, I just need to change the size of 
	 first element to get all the rest to follow"
	widgets first sizeRequest: newWidth @ (widgets first preferredSizeMinimum y) 
]

{ #category : #private }
GtkMillerAdapter >> recalculatePages [

	self widget ifNil: [ ^ self ].
	self childrenWidgets ifEmpty: [ ^ self ].
	((lastExtent = self widget size) 
		and: [ lastPageSize = self childrenWidgets size ]) 
		ifTrue: [ ^ self ].

	[ layout direction recalculatePages: self ]
	ensure: [ 
		lastExtent := self widget size.
		lastPageSize := self childrenWidgets size ]
]

{ #category : #removing }
GtkMillerAdapter >> remove: aPresenter [
	| childWidget |

	childWidget := aPresenter adapter widget.
	(innerWidget children includes: childWidget) ifTrue: [  
		innerWidget remove: childWidget.
		self recalculatePages.
		self scrollToShowLastPage ]
]

{ #category : #removing }
GtkMillerAdapter >> removeAll [

	self widget removeAll
]

{ #category : #private }
GtkMillerAdapter >> scrollToShowLastPage [

	innerWidget children ifEmpty: [ ^ self ].
	innerWidget children size = 1 ifTrue: [ ^ self ].
	
	self flag: #HACK. "This is needed because once added a children, the children will 
	not have immediately a real position, so we cannot scroll. 
	Positions and sizes in Gtk3 are calculated in the redrawing loop, to prevent multiple 
	sizing at once. We need to wait until this happens so the scrolling has sense."
	[
		1 milliSecond wait.
		[ self doScrollToShowLastPage ]
		on: Error do: [ :e | 
			"do not lost the error if any, but do not stop because of it"
			e emit. 
			e messageText crTrace ]
	] asTask schedule: TKTNewProcessTaskRunner new
]

{ #category : #private }
GtkMillerAdapter >> toggleVisible: isVisible [

	isVisible 
		ifTrue: [ widget show ] 
		ifFalse: [ widget hide ]
]

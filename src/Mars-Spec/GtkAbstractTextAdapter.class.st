Class {
	#name : #GtkAbstractTextAdapter,
	#superclass : #GtkAdapter,
	#category : #'Mars-Spec-Adapter'
}

{ #category : #building }
GtkAbstractTextAdapter >> addMenu: aValuable to: gtkWidget [ 
	"for texts, this is solved with #populatePopup:, see there to follow 
	 how it works."
	self shouldNotImplement
]

{ #category : #building }
GtkAbstractTextAdapter >> addModelTo: gtkWidget [

	super addModelTo: gtkWidget.
	self addTextTo: gtkWidget. 
	self model whenTextChangedDo: [ :text | 
		self setText: text to: gtkWidget ].
	gtkWidget connectPopulatePopup: [ :menuWidget |
		self populatePopup: menuWidget  ]
]

{ #category : #building }
GtkAbstractTextAdapter >> addTextTo: gtkWidget [
	
	self model text ifNotNil: [ :text | 
		self setText: text to: gtkWidget ].

]

{ #category : #'spec protocol' }
GtkAbstractTextAdapter >> insert: aString at: positionIndex [

	self innerWidgetDo: [ :w |
		w textBuffer 
			insertText: aString 
			at: positionIndex - 1 ]
]

{ #category : #building }
GtkAbstractTextAdapter >> populatePopup: menuWidget [
	| newMenu menuPresenter |
	
	menuPresenter := self model contextMenu value.
	menuPresenter ifNil: [ ^ self ].
	
	lastShownMenu := menuWidget.
	newMenu := self buildMenu: menuPresenter.
	newMenu children reverseDo: [ :each |
		newMenu remove: each.
		menuWidget addFirst: each.
		each show ]
]

{ #category : #emulating }
GtkAbstractTextAdapter >> rightClicked [
	
	self innerWidget 
		withCallbacksOfType: GPopulatePopupCallback 
		do: [ :aCallback |
			aCallback valueWithArguments: {
				self innerWidget getHandle.
				GtkMenu new getHandle.
				ExternalAddress null } ]
]

{ #category : #selection }
GtkAbstractTextAdapter >> selectAll [
	
	self widget selectAll
]

{ #category : #'spec protocol' }
GtkAbstractTextAdapter >> selectLine [

	self innerWidget ifNotNil: [ :w | 
		w textBuffer selectLineAtCursor ]
]

{ #category : #'spec protocol' }
GtkAbstractTextAdapter >> selection [ 

	^ self innerWidget 
		ifNotNil: [ :w | 
			| selection |
			selection := w textBuffer selection.
			selection ifNotNil: [ 
				selection first + 1 to: selection last ] ]	
		ifNil: [ 
			1 to: 0 ]
]

{ #category : #'spec protocol' }
GtkAbstractTextAdapter >> setSelectionFromModel: aSelection [
 
	self innerWidget ifNotNil: [ :w | 
		w textBuffer 
			selectFrom: aSelection first - 1
			to: aSelection last ]
]

{ #category : #accessing }
GtkAbstractTextAdapter >> setText: aString to: gtkWidget [

	gtkWidget text: aString asString
]

{ #category : #accessing }
GtkAbstractTextAdapter >> text: aString [ 
	
	self setText: aString to: widget
]

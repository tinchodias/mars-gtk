Class {
	#name : #GtkRunLoop,
	#superclass : #Object,
	#traits : 'TGtkLibrary',
	#classTraits : 'TGtkLibrary classTrait',
	#instVars : [
		'session',
		'running',
		'executing'
	],
	#pools : [
		'GtkTypes'
	],
	#classInstVars : [
		'current',
		'uniqueInstance'
	],
	#category : 'Mars-Gtk-Base'
}

{ #category : #accessing }
GtkRunLoop class >> current [
	^ current ifNil: [ current := self defaultRunLoopClass uniqueInstance ]
]

{ #category : #accessing }
GtkRunLoop class >> current: aRunLoop [
	current ifNotNil: [ current stop ].
	current := aRunLoop
]

{ #category : #private }
GtkRunLoop class >> defaultRunLoopClass [
	^ GtkPluginRunLoop
]

{ #category : #'instance creation' }
GtkRunLoop class >> new [
	^ self error: 'Use #uniqueInstance'
]

{ #category : #accessing }
GtkRunLoop class >> reset [
	self current: nil
]

{ #category : #'instance creation' }
GtkRunLoop class >> uniqueInstance [
	self = GtkRunLoop 
		ifTrue: [ self error: 'I''m an abstract class. Use #uniqueInstance' ].
	^ uniqueInstance ifNil: [ uniqueInstance := self basicNew initialize ]
]

{ #category : #private }
GtkRunLoop >> checkSession [
	^ session == Smalltalk session
]

{ #category : #private }
GtkRunLoop >> doNotOverlap: aBlock [
	executing ifTrue: [ ^ self ].
	executing := true.
	aBlock ensure: [ executing := false ]

]

{ #category : #private }
GtkRunLoop >> getEventsPending [
	^ self ffiCall: #(gboolean gtk_events_pending (void))
]

{ #category : #initialization }
GtkRunLoop >> initialize [ 
	super initialize.
	running := false.
	executing := false
]

{ #category : #'private installing' }
GtkRunLoop >> installRunLoop [
	self subclassResponsibility
]

{ #category : #testing }
GtkRunLoop >> isRunning [
	^ running
]

{ #category : #private }
GtkRunLoop >> mainIterationDo: blocking [
	^ self ffiCall: #( void gtk_main_iteration_do ( gboolean blocking ) )
]

{ #category : #private }
GtkRunLoop >> processEvents [
	self doNotOverlap: [
		[ (self isRunning and: [ self checkSession ])
			ifTrue: [ self getEventsPending ]
			ifFalse: [ false ] ]
		whileTrue: [ self mainIterationDo: false ] ]
]

{ #category : #running }
GtkRunLoop >> start [
	self isRunning ifTrue: [ ^ self ].
	
	running := true.
	session := Smalltalk session. 
	self installRunLoop.
]

{ #category : #running }
GtkRunLoop >> stop [ 
	self isRunning ifFalse: [ ^ self ].
	self uninstallRunLoop.	
	running := false

]

{ #category : #'private installing' }
GtkRunLoop >> uninstallRunLoop [
	self subclassResponsibility
]
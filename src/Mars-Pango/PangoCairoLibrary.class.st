"
I'm a library to add bindings with pango-cairo.
"
Class {
	#name : #PangoCairoLibrary,
	#superclass : #FFILibrary,
	#category : #'Mars-Pango-Base'
}

{ #category : #accessing }
PangoCairoLibrary >> calloutAPIClass [ 

	^ TFCalloutAPI
]

{ #category : #'accessing platform' }
PangoCairoLibrary >> macLibraryName [

	GtkLibrary isDebug ifTrue: [ ^ '/Users/gtk3/gtk/inst/lib/libpangocairo-1.0.0.dylib' ]. 
	^ '/usr/local/lib/libpangocairo-1.0.0.dylib'

]

{ #category : #accessing }
PangoCairoLibrary >> runner [
	
	^ TFSameThreadRunner new
]

{ #category : #'accessing platform' }
PangoCairoLibrary >> unix32LibraryName [ 

	^ '/usr/lib/i386-linux-gnu/libpangocairo-1.0.so.0'
]

{ #category : #'accessing platform' }
PangoCairoLibrary >> unix64LibraryName [ 

	^ '/usr/lib/x86_64-linux-gnu/libpangocairo-1.0.so.0'
]

{ #category : #'accessing platform' }
PangoCairoLibrary >> win32LibraryName [

	^ 'libpangocairo-1.0-0.dll'
]

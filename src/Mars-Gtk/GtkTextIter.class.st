"
GtkTextIter — Text buffer iterator

https://developer.gnome.org/gtk3/stable/GtkTextIter.html

WARNING: GtkTextIter is an opaque type that is, however, threat as a regular structure (handled in the stack and not in the heap). That's the reason of all those dummys instead real fields (and it is not my fault, is like that on Gtk3 itself) 
"
Class {
	#name : #GtkTextIter,
	#superclass : #GtkStructure,
	#classVars : [
		'OFFSET_DUMMY1',
		'OFFSET_DUMMY10',
		'OFFSET_DUMMY11',
		'OFFSET_DUMMY12',
		'OFFSET_DUMMY13',
		'OFFSET_DUMMY14',
		'OFFSET_DUMMY2',
		'OFFSET_DUMMY3',
		'OFFSET_DUMMY4',
		'OFFSET_DUMMY5',
		'OFFSET_DUMMY6',
		'OFFSET_DUMMY7',
		'OFFSET_DUMMY8',
		'OFFSET_DUMMY9'
	],
	#category : #'Mars-Gtk-Misc'
}

{ #category : #'field definition' }
GtkTextIter class >> fieldsDesc [ 
	"From gtktextiter.h: 
	/* GtkTextIter is an opaque datatype; ignore all these fields.
    * Initialize the iter with gtk_text_buffer_get_iter_*
    * functions
    */	
	"
	
	^ #(
  gpointer dummy1;
  gpointer dummy2;
  gint dummy3;
  gint dummy4;
  gint dummy5;
  gint dummy6;
  gint dummy7;
  gint dummy8;
  gpointer dummy9;
  gpointer dummy10;
  gint dummy11;
  gint dummy12;
  "/* padding */"
  gint dummy13;
  gpointer dummy14;	
	)
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy1 [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_DUMMY1) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy10 [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_DUMMY10) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy10: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_DUMMY10 put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy11 [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_DUMMY11
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy11: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_DUMMY11 put: anObject
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy12 [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_DUMMY12
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy12: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_DUMMY12 put: anObject
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy13 [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_DUMMY13
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy13: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_DUMMY13 put: anObject
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy14 [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_DUMMY14) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy14: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_DUMMY14 put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy1: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_DUMMY1 put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy2 [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_DUMMY2) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy2: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_DUMMY2 put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy3 [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_DUMMY3
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy3: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_DUMMY3 put: anObject
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy4 [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_DUMMY4
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy4: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_DUMMY4 put: anObject
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy5 [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_DUMMY5
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy5: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_DUMMY5 put: anObject
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy6 [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_DUMMY6
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy6: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_DUMMY6 put: anObject
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy7 [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_DUMMY7
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy7: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_DUMMY7 put: anObject
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy8 [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_DUMMY8
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy8: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_DUMMY8 put: anObject
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy9 [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_DUMMY9) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
GtkTextIter >> dummy9: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_DUMMY9 put: anObject getHandle.
]
#|
  This file is a part of ningle project.
  Copyright (c) 2012 Eitarow Fukamachi (e.arrows@gmail.com)
|#

(in-package :cl-user)
(defpackage ningle.middleware.context
  (:use :cl
        :clack)
  (:import-from :ningle.context
                :*context*
                :*request*
                :*response*
                :*session*
                :context
                :make-context)
  (:import-from :clack.response
                :make-response
                :body
                :finalize))
(in-package :ningle.middleware.context)

(cl-syntax:use-syntax :annot)

@export
(defclass <ningle-middleware-context> (<middleware>) ()
  (:documentation "Clack Middleware to set context for each request."))

(defmethod call ((this <ningle-middleware-context>) req)
  (let* ((*context* (make-context req))
         (*request* (context :request))
         (*response* (context :response))
         (*session* (context :session))
         (result (call-next this req)))
    (if (and result (listp result))
        result
        (progn (setf (body *response*) result)
               (finalize *response*)))))

(doc:start)

@doc:NAME "
Ningle.Middleware.Context - Clack Middleware to set context for each request.
"

@doc:DESCRIPTION "
This is a Clack Middleware to ensure context is set for each request.
"

@doc:AUTHOR "
* Eitarow Fukamachi (e.arrows@gmail.com)
"

@doc:SEE "
* Ningle.Context
"

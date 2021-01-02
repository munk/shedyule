(defpackage shedyule
  (:use :cl)
  (:export
   :make-scheduler
   :schedule-job
   :scheduled-p
   :run-scheduler))
(in-package :shedyule)

;;; Scheduler
(defclass Scheduler ()
  ((jobs :initform (make-hash-table) :accessor jobs)))

(defun make-scheduler ()
  (make-instance 'Scheduler))

(defmethod schedule-job ((scheduler Scheduler) job job-name &rest trigger)
  (setf (gethash job-name (jobs scheduler)) (make-job job nil)))

(defun scheduled-p (scheduler job-name)
  (if (gethash job-name (jobs scheduler))
      t
      nil))

(defun run-scheduler (scheduler)
  (maphash (lambda (k fn) (run-job fn)
		   (progn
		     (print k)))
	   (jobs scheduler)))

;;; Job
(defclass Job ()
  ((fn :initarg :fn :accessor job-fn)
   (trigger :initarg :trigger :accessor job-trigger)))

(defun make-job (job-fn trigger)
  (make-instance 'Job :fn job-fn :trigger trigger))

(defmethod ready? ((job Job) now)
  (let ((trigger (job-trigger job)))
    (> now (next-run trigger))))

(defmethod run-job ((job Job))
  (funcall (job-fn job)))


(defun next-run (trigger)
  (case trigger
    (:now 0)
    (:every-minute 1)))


;;; Trigger
(defclass Trigger ()
  ((last-run-time :initarg nil :accessor last-run-time)
   (next-run-time :initarg nil :accessor next-run-time)))

(defgeneric ready? (trigger now))

(defpackage shedyule-test
  (:use :cl
        :shedyule
        :prove))
(in-package :shedyule-test)

;; NOTE: To run this test file, execute `(asdf:test-system :shedyule)' in your Lisp.

(plan nil)

(subtest "Showing off Prove"
  (ok (not (find 4 '(1 2 3))))
  (is 4 4)
  (isnt 1 #\1))

(subtest "I can schedule a job to run later"
  (let* ((job-result nil)
	 (scheduler (shedyule:make-scheduler))
	 (job-name "test-job")
	 (job (lambda () (setf job-result t))))
    (shedyule:schedule-job scheduler job job-name)
    (ok (shedyule:scheduled-p scheduler job-name))))

(subtest "A job that doesn't exist is not scheduled"
  (let* ((scheduler (shedyule:make-scheduler))
	 (job-name "test-job"))
    (ok (not (shedyule:scheduled-p scheduler job-name)))))

(subtest "A job that is set to run immediately will run immediately"
  (let* ((job-result nil)
	 (scheduler (shedyule:make-scheduler))
	 (job-name "test-job")
	 (job (lambda () (setf job-result t))))
    (shedyule:schedule-job scheduler job job-name :now)
    (shedyule:run-scheduler scheduler)
    (ok job-result)))

;;; run a job later
;;; don't run a job if it's not time yet
;;; replace a job ...
;;; reschedule a job
;;; pause a job
;;; add listeners
;;; valid run window
;;; max instances

;;; TODO: pick another testing framework, CL Cookbook says :Prove is obsolete - Rove or FiveAM*

(finalize)

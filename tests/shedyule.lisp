(defpackage shedyule-test
  (:use :cl
	:shedyule
	:rove))
(in-package :shedyule-test)

;; NOTE: To run this test file, execute `(asdf:test-system :shedyule)' in your Lisp.

(deftest sheduler-test
  (testing "I can schedule a job to run later"
    (let* ((job-result nil)
	   (scheduler (shedyule:make-scheduler))
	   (job-name "test-job")
	   (job (lambda () (setf job-result t))))
      (shedyule:schedule-job scheduler job job-name)
      (ok (shedyule:scheduled-p scheduler job-name))))


  (testing "A job that doesn't exist is not scheduled"
    (let* ((scheduler (shedyule:make-scheduler))
	   (job-name "test-job"))
      (ok (not (shedyule:scheduled-p scheduler job-name)))))

  (testing "A job that is set to run immediately will run immediately"
    (let* ((job-result nil)
	   (scheduler (shedyule:make-scheduler))
	   (job-name "test-job")
	   (job (lambda () (setf job-result t))))
      (shedyule:schedule-job scheduler job job-name :now)
      (shedyule:run-scheduler scheduler)
      (ok job-result))))

;;; run a job later
;;; don't run a job if it's not time yet
;;; replace a job ...
;;; reschedule a job
;;; pause a job
;;; add listeners
;;; valid run window
;;; max instances

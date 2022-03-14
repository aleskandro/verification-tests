Feature: Scheduler related scenarios

  # @author wmeng@redhat.com
  # @case_id OCP-14582
  @4.10 @4.9
  @vsphere-ipi @openstack-ipi @gcp-ipi @baremetal-ipi @azure-ipi @aws-ipi
  @vsphere-upi @openstack-upi @gcp-upi @baremetal-upi @azure-upi @aws-upi
  @singlenode
  @disconnected @connected
  Scenario: When no scheduler name is supplied, the pod is automatically scheduled using the default-scheduler
    Given I have a project
    Given I obtain test data file "scheduler/multiple-schedulers/pod-no-scheduler.yaml"
    When I run the :create client command with:
      | f | pod-no-scheduler.yaml |
    Then the step should succeed
    Given the pod named "no-scheduler" becomes ready
    When I run the :describe client command with:
      | resource | pods         |
      | name     | no-scheduler |
    Then the output should match:
      | Status:\\s+Running |
      | default-scheduler  |


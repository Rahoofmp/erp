{if $box && $flashdata}
{if $type }
{assign var="message_class" value="bg-primary"}
{else}
{assign var="message_class" value="bg-danger"}
{/if}
<style type="text/css">
	.alert.alert-with-icon {
		margin-top: 0px !important;
	}
</style>


<div id="liveToast" class="toast d-flex align-items-center text-white {$message_class} border-0 mb-1" role="alert" aria-live="assertive" aria-atomic="true" data-bs-autohide="true">
	<div class="toast-body">
		{$flashdata}
	</div>
	<button type="button" class="btn-close btn-close-white ms-auto me-2" data-bs-dismiss="toast" aria-label="Close"></button>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
    var toastEl = document.getElementById('liveToast');
    if (toastEl) {
        var toast = new bootstrap.Toast(toastEl);
        toast.show(); 
        toastEl.addEventListener('hidden.bs.toast', function () {
            toastEl.classList.remove('mb-1');
        });
    }
});
</script>

{/if}




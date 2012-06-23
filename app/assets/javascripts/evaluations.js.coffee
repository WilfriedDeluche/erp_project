

jQuery ->
	$("#search_form #subject_id").change ->
		$.getScript window.location + "?subject_id=" + $(this).val()
		

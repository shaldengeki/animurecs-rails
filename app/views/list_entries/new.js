$("#list-entry-form").html("<%= escape_javascript(render(:partial => "form")) %>");
$('#list_entry_last_watched_at').datetimepicker({dateFormat: "yy-mm-dd", timeFormat: "hh:mm:ss"});
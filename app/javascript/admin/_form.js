$(document).on('ready', () => {
  const $endDateField = $('#end_date');

  if ($endDateField.length > 0) {
    const today = new Date();
    const year = today.getFullYear();
    const month = (today.getMonth() + 1).toString().padStart(2, '0');
    const day = (today.getDate()).toString().padStart(2, '0');

    $endDateField.attr('min', `${year}-${month}-${day}`);
  }
});

# Environment variables
export name="phani"
echo "Name before process kill :: $name"

process_id=pgrep bash
echo "${process_id}"
kill process_id

echo "Name after process kill :: $name"


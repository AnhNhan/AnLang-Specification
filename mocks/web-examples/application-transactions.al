
// See Converge's AnhNhan\Converge\Modules\Task\Controllers\TaskEditController to see the PHP code

struct TaskEditController
{
    mixin BaseApplicationController

    fn handle()
    {
        id = this.request.query.get('id')
        task = this.entities.tasks.search(id)

        // Q: Introduce 'was' keyword as syntactic sugar, having same meaning as 'is'?
        if (task is NotFound)
        {
            // Create an empty task, annotated with the NewlyCreatedTask type
            task = NewlyCreatedTask(Task())
        }

        if (this.request.method is HttpPostMethod)
        {
            new_label = this.request.data.get('label')
            new_description = this.request.data.get('description')

            editor = this.entities.tasks.editor.edit(task, actor = this.request.user)
            _task = editor.get_mock

            if (task is NewlyCreatedTask)
            {
                _task.create()
            }

            _task.label = new_label
            _task.description = new_description

            this.entities.tasks.recorder.record(editor.apply)

            return this.redirect.to('task/' ~ task.label_canonical)
        }

        // Display form to create task ...
    }
}

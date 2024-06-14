% rebase('templates/skeleton.tpl', title=title)

<h1 class="mt-5">Instructions</h1>

<div id="screensize_error" class="alert alert-danger" style="display:none">
    Your browser window is not large enough, please maximize your window.
</div>

<p>
You will see various images.
The task will then be to evaluate the images in terms of image quality, image appeal , realisim and text prompt matching.

</p>



<div class="alert alert-secondary" role="alert">
Please rate the images carefully as possible. There are no right or wrong answers.
</div>
<div class="alert alert-secondary" role="alert">
Please maximize your browser window.
</div>

<p>
<a class="btn btn-large btn-success" href="{{next}}" onclick="check_screensize(event)"  id="next">next</a>
</p>





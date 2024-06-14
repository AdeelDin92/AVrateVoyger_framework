<div class="col-12">
    % is_image = stimuli_file.split(".")[-1].lower() in ["jpg", "jpeg", "png", "gif", "tiff"]

    <div class="row">
        <div class="col-12 align-top">
            % if is_image:
           <img src="/{{'train' if 'train' in stimuli_file else 'stimuli'}}/{{stimuli_file.split('/', 2)[-1]}}" alt="Stimuli Image">

            % end
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <div id="info" style="display:none;cursor:default" class="btn alert-success" disabled>
              Please view the image
            </div>
            <div id="loader" class="" role="status">
              <span class="visually-hidden">Loading...</span>
            </div>
        </div>
    </div>
</div>

<script>
function store_window_size() {
    var h = window.innerHeight;
    var w = window.innerWidth;
    document.getElementById("ww").value = w;
    document.getElementById("wh").value = h;
    document.getElementById("wz").value = window.devicePixelRatio; // store zoom factor
}

function image_loaded() {
    console.log("image loaded");
    store_window_size();

    document.getElementById("info").style.display = "none";
    document.getElementById("loader").style.display = "none";
}
</script>

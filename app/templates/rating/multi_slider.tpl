<div id="ratingform">
    <h5>Please rate the following properties of the shown image.</h5>

    <style>
        .slider {
            width: 100% !important;
        }
    </style>

    <%
    prompts = {
        "p01": "A red colored car",
        "p02": "A green cup and a blue cell phone",
        "p03": "A pizza cooking an oven",
        "p04": "Two cars on the street",
        "p05": "A cat on the right of a tennis racket",
        "p06": "A fish eating a pelican",
        "p07": "Two cats and one dog sitting on the grass",
        "p08": "A triangular pink stop sign. A pink stop sign in the shape of triangle",
        "p09": "A couple of glasses are sitting on a table",
        "p10": "A photo of a confused grizzly bear in calculus class",
        "p11": "A connection point by which firefighters can tap into a water supply",
        "p12": "A mechanical or electrical device for measuring time",
        "p13": "A tennis racket underneath a traffic light",
        "p14": "A pear cut into seven pieces arranged in a ring",
        "p15": "A sheep to the right of a wine glass",
        "p16": "A sign that says 'Diffusion'",
        "p17": "Hyper-realistic photo of an abandoned industrial site during a storm",
        "p18": "A sign that says 'Text to Image'",
        "p19": "A bee is on a flower with a green background",
        "p20": "A row of classic cars parked in a parking lot",
        "p21": "A board that says 'make this day great'",
        "p22": "A blue scooter parked in front of a store",
        "p23": "A cocktail with chili peppers and a glass",
        "p24": "Two geese walking along the bank of a river",
        "p25": "Two penguins standing on the ground near some rocks",
        "p26": "A pair of yellow sandals on a white surface",
        "p27": "Adorable brown puppy sitting in wooden box",
        "p28": "Woman strolling with her dog in a misty park",
        "p29": "Man wearing hat strums guitar outdoors",
        "p30": "A butterfly peacefully sitting on a lush leaf",
    }

    imageid = stimuli_file.split("/")[-1].split(".")[0]
    prompt = prompts.get(imageid, "")
    %>

    

    <%
    aspects = [
        ("image appeal", "refers to the quality of being attractive or interesting"),
        ("realism", "refers to visuals that closely resemble natural real image"),
        ("image quality", " refers to the technical quality of the images")
    ]
    
    route = f"save_rating?stimuli_idx={stimuli_idx}" if not train else "training/" + str(stimuli_idx + 1)
    %>

    <form id="form1" action="/{{route}}" method="post">
        <table class="table table-sm">
            <thead>
                <tr>
                    <th scope="col"></th>
                    <th scope="col"></th>
                    <th scope="col"><small>bad</small></th>
                    <th scope="col" style="text-align:center"></th>
                    <th scope="col"><small>very good</small></th>
                </tr>
            </thead>
            <tbody>
                % for aspect, description in aspects:
                % aspect_key = aspect.replace(" ", "_")
                <tr>
                    <td style="width:30%">{{aspect}} <br><small>({{description}})</small></td>
                    <td style="width:15%"><input type="number" min="1" max="5" id="label_range_{{aspect_key}}" style="width:3em" onchange="update_slider(this, 'range_{{aspect_key}}')" required></td>
                    <td style="width:8em">1</td>
                    <td style="width:50%">
                        <input
                            type="range"
                            class="slider"
                            name="range_{{aspect_key}}"
                            id="range_{{aspect_key}}"
                            min="1"
                            max="5"
                            value="3"
                            oninput="slider_change(this)"
                            onchange="slider_change(this)"
                            list="steplist"
                        />
                        <datalist id="steplist">
                            <option>1</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                            <option>5</option>
                        </datalist>
                    </td>
                    <td style="width:8em">5</td>
                </tr>
                % end

                <tr>
                    <td colspan="5" style="border-style:none; padding-top:1em">Is the following text a good description of the image:</td>
                </tr>
                <tr>
                    <td colspan="5" style="border-style:none">{{prompt}}</td>
                </tr>
                <%
                aspect_key = "prompt_matching"
                aspect = "prompt matching"
                %>
                <tr>
                    <td style="width:15%"></td>
                    <td style="width:15%"><input type="number" min="1" max="5" id="label_range_{{aspect_key}}" style="width:3em" onchange="update_slider(this, 'range_{{aspect_key}}')" required></td>
                    <td style="width:8em">1</td>
                    <td style="width:50%">
                        <input
                            type="range"
                            class="slider"
                            name="range_{{aspect_key}}"
                            id="range_{{aspect_key}}"
                            min="1"
                            max="5"
                            value="3"
                            oninput="slider_change(this)"
                            onchange="slider_change(this)"
                            list="steplist"
                        />
                        <datalist id="steplist">
                            <option>1</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                            <option>5</option>
                        </datalist>
                    </td>
                    <td style="width:8em">5</td>
                </tr>
            </tbody>
        </table>

        % include('templates/rating/common.tpl', stimuli_file=stimuli_file)

        <button type="submit" id="submitButton" class="btn btn-success btn-block">submit</button>

        % if dev:
        <button type="submit" class="btn btn-success" formnovalidate>skip (for dev)</button>
        % end

        <div id="ratingselect" class="btn alert-danger" style="display:none;cursor:default; margin-top: 0.5em; margin-bottom: 0.5em" disabled>Please select a rating.</div>
    </form>
</div>

<script>
    var slidersChanged = {};
    // initialize sliders
    for (const slider of document.querySelectorAll('input.slider')) {
        slidersChanged[slider.getAttribute("name")] = 0;
    }

    function update_slider(input, range_id) {
        var slider = document.getElementById(range_id);
        slider.value = input.value
    }

    function slider_change(slider) {
        const label = document.getElementById("label_" + slider.getAttribute("name"));
        label.value = slider.value;

        slidersChanged[slider.getAttribute("name")] = 1;
        var check = Object.values(slidersChanged).every(e => e > 0);

        if (check) {
            document.getElementById("submitButton").disabled = false;
        }
    }

    function display_rating() {
        document.getElementById("ratingform").style.display = "block";
    }
</script>

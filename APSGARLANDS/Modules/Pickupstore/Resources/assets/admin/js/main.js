

$("#country").on("change", (e) => {
    let oldState = $("#state").val();

    $.ajax({
        type: "GET",
        url: route("countries.states.index", e.currentTarget.value),
        success(states) {
            $(".state").addClass("hide");

            if (_.isEmpty(states)) {
                return $(".state.input")
                    .removeClass("hide")
                    .find("input")
                    .val(oldState);
            }

            let options = "";

            for (let code in states) {
                options += `<option value="${code}">${states[code]}</option>`;
            }

            $(".state.select")
                .removeClass("hide")
                .find("select")
                .html(options)
                .val(oldState);
        },
    });
});

$(function () {
    $("#country").trigger("change");
});

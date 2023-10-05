

$("#store_country").on("change", (e) => {
    let oldState = $("#store_state").val();

    $.ajax({
        type: "GET",
        url: route("countries.states.index", e.currentTarget.value),
        success(states) {
            $(".store-state").addClass("hide");

            if (_.isEmpty(states)) {
                return $(".store-state.input")
                    .removeClass("hide")
                    .find("input")
                    .val(oldState);
            }

            let options = "";

            for (let code in states) {
                options += `<option value="${code}">${states[code]}</option>`;
            }

            $(".store-state.select")
                .removeClass("hide")
                .find("select")
                .html(options)
                .val(oldState);
        },
    });
});

$(function () {
    $("#store_country").trigger("change");
});

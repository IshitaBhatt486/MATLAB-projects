
function root_locus
    clc;
    close all;

    % Run automated tests first
    runTests();

    % Interactive Root Locus Explorer
    fig = figure( ...
        'Name', 'Interactive Root Locus Explorer', ...
        'NumberTitle', 'off', ...
        'Color', 'w', ...
        'Position', [100 100 1000 650]);

    ax = axes('Parent', fig, ...
        'Position', [0.10 0.34 0.85 0.61]);

    hold(ax, 'on');
    grid(ax, 'on');
    box(ax, 'on');

    title(ax, 'Interactive Root Locus Explorer');
    xlabel(ax, 'Real Axis');
    ylabel(ax, 'Imaginary Axis');

    % Default values
    K0 = 1;
    a0 = 2;
    b0 = 1;

    locusPlot1 = plot(ax, NaN, NaN, 'b-', 'LineWidth', 2);
    locusPlot2 = plot(ax, NaN, NaN, 'b-', 'LineWidth', 2);

    openPolesPlot = plot(ax, NaN, NaN, 'kx', ...
        'MarkerSize', 10, 'LineWidth', 2);

    closedPolesPlot = plot(ax, NaN, NaN, 'ro', ...
        'MarkerSize', 9, 'MarkerFaceColor', 'r', ...
        'LineStyle', 'none');

    makeLabel('Gain K', [0.03 0.25 0.12 0.035]);
    sliderK = makeSlider(K0, 0, 100, ...
        [0.15 0.26 0.55 0.025]);

    makeLabel('Coefficient a', [0.03 0.19 0.12 0.035]);
    sliderA = makeSlider(a0, 0, 10, ...
        [0.15 0.20 0.55 0.025]);

    makeLabel('Coefficient b', [0.03 0.13 0.12 0.035]);
    sliderB = makeSlider(b0, 0.1, 25, ...
        [0.15 0.14 0.55 0.025]);

    makeLabel('Feedback', [0.76 0.25 0.10 0.035]);

    feedbackMenu = uicontrol(fig, ...
        'Style', 'popupmenu', ...
        'String', {'Negative', 'Positive'}, ...
        'Value', 1, ...
        'Units', 'normalized', ...
        'Position', [0.85 0.25 0.12 0.04], ...
        'Callback', @updatePlots);

    statusText = uicontrol(fig, ...
        'Style', 'text', ...
        'Units', 'normalized', ...
        'Position', [0.03 0.02 0.94 0.07], ...
        'FontSize', 10, ...
        'BackgroundColor', 'w', ...
        'HorizontalAlignment', 'left', ...
        'String', '');

    sliderK.Callback = @updatePlots;
    sliderA.Callback = @updatePlots;
    sliderB.Callback = @updatePlots;

    updatePlots();

    function h = makeSlider(value, minimum, maximum, position)
        h = uicontrol(fig, ...
            'Style', 'slider', ...
            'Min', minimum, ...
            'Max', maximum, ...
            'Value', value, ...
            'Units', 'normalized', ...
            'Position', position, ...
            'SliderStep', [0.01 0.10]);
    end

    function makeLabel(labelText, position)
        uicontrol(fig, ...
            'Style', 'text', ...
            'String', labelText, ...
            'Units', 'normalized', ...
            'Position', position, ...
            'BackgroundColor', 'w', ...
            'HorizontalAlignment', 'left');
    end

    function updatePlots(~, ~)
        K = get(sliderK, 'Value');
        a = get(sliderA, 'Value');
        b = get(sliderB, 'Value');

        negativeFeedback = get(feedbackMenu, 'Value') == 1;
        if negativeFeedback
            feedbackSign = 1;
            feedbackName = 'Negative';
        else
            feedbackSign = -1;
            feedbackName = 'Positive';
        end

        openPoles = roots([1 a b]);
        closedPoles = roots([1 a b + feedbackSign*K]);

        % Recalculate root locus across gain range
        Kvalues = linspace(0, 100, 600);
        locusPoles = zeros(2, numel(Kvalues));

        for n = 1:numel(Kvalues)
            locusPoles(:, n) = roots( ...
                [1 a b + feedbackSign*Kvalues(n)]);
        end

        set(locusPlot1, 'XData', real(locusPoles(1,:)), ...
            'YData', imag(locusPoles(1,:)));
        set(locusPlot2, 'XData', real(locusPoles(2,:)), ...
            'YData', imag(locusPoles(2,:)));

        set(openPolesPlot, 'XData', real(openPoles), ...
            'YData', imag(openPoles));
        set(closedPolesPlot, 'XData', real(closedPoles), ...
            'YData', imag(closedPoles));

        xlim(ax, [-15 5]);
        ylim(ax, [-15 15]);

        % Stability check
        if all(real(closedPoles) < -1e-9)
            stability = 'STABLE';
        elseif any(real(closedPoles) > 1e-9)
            stability = 'UNSTABLE';
        else
            stability = 'MARGINALLY STABLE / CHECK POLES';
        end

        set(statusText, 'String', sprintf( ...
            'K=%.2f | a=%.2f | b=%.2f | %s feedback | %s', ...
            K, a, b, feedbackName, stability));

        drawnow;
    end
end

function runTests()

    % Each test: K, a, b, positive-feedback flag, expected stability
    tests = {
        1,  2, 1, false, 'STABLE';
        20, 1, 1, false, 'STABLE';
        5,  2, 1, true,  'UNSTABLE';
        1,  5, 1, false, 'STABLE';
        0,  2, 1, false, 'STABLE'
    };

    passed = 0;

    for i = 1:size(tests, 1)
        K = tests{i, 1};
        a = tests{i, 2};
        b = tests{i, 3};
        positiveFeedback = tests{i, 4};
        expected = tests{i, 5};

        if positiveFeedback
            constantTerm = b - K;
        else
            constantTerm = b + K;
        end

        p = roots([1 a constantTerm]);

        if all(real(p) < -1e-9)
            actual = 'STABLE';
        elseif any(real(p) > 1e-9)
            actual = 'UNSTABLE';
        else
            actual = 'MARGINALLY STABLE / CHECK POLES';
        end

        % Verify the characteristic polynomial roots
        residual = max(abs(polyval([1 a constantTerm], p)));
        rootsCorrect = residual < 1e-7;
        testPassed = strcmp(actual, expected) && rootsCorrect;

        if testPassed
            passed = passed + 1;
            result = 'PASS';
        else
            result = 'FAIL';
        end

        fprintf(['Test %d: %s | K=%.1f, a=%.1f, b=%.1f | ' ...
            'Expected: %s, Got: %s\n'], ...
            i, result, K, a, b, expected, actual);

        fprintf('    Poles: ');
        disp(p.');
    end

    fprintf('Result: %d/%d tests passed.\n\n', ...
        passed, size(tests, 1));
end

App = {
    web3Provider: null,
    contracts: {},

    init: function () {
        
        return App.initWeb3();
    },

    initWeb3: function() {
        if(typeof web3 !== 'undefined') {
            App.web3Provider = web3.currentProvider;
        } else {
            App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
        }
        web3 = new Web3(App.web3Provider);

        return App.initContract();
    },

    initContract: function() {
        
        $.getJSON('SELFToken.json',function(data){
            var SELFTokenArtifact = data;
            App.contracts.SELFToken = TruffleContract(SELFTokenArtifact);
            App.contracts.SELFToken.setProvider(App.web3Provider);
            
        });

        return App.bindEvents();
    },

    bindEvents: function() {
        //self-token operations.
        $(document).on('click', '.btn-holder', App.handleGetHolder);
        $(document).on('click', '.btn-step', App.handleGetStep);
        $(document).on('click', '.btn-timer', App.handleGetTimer);
        $(document).on('click', '.btn-timerStep', App.handleGetTimerStep);
        $(document).on('click', '.btn-counter', App.handleGetCounter);
        $(document).on('click', '.btn-withdraw', App.handleGetCounter);

        //copyroght opertions.
        $(document).on('click', '.btn-queryCopyright', App.handleQueryCopyright);
        $(document).on('click', '.btn-getManager', App.handleGetManager);

        //transaction opertions.
        $(document).on('click', '.btn-send', App.handleTransaction);
        
    },

    handleGetHolder: function(event) {
        var index = parseInt($('#input-code').val());

        App.contracts.SELFToken.deployed().then(function(instance){
            return instance.getLockedFundsHolder(index);
        }).then(function(holder){
            alert('the holder is ' + holder);
        });
    },

    handleGetStep: function(event) {
        var index = parseInt($('#input-code').val());

        App.contracts.SELFToken.deployed().then(function(instance){
            return instance.getLockedFundsStep(index);
        }).then(function(step){
            alert('the step is ' + step);
        });
    },

    handleGetTimer: function(event) {
        var index = parseInt($('#input-code').val());

        App.contracts.SELFToken.deployed().then(function(instance){
            return instance.getLockedFundsTimer(index);
        }).then(function(timer){
            alert('the timer is ' + timer);
        });
    },

    handleGetTimerStep: function(event) {
        var index = parseInt($('#input-code').val());

        App.contracts.SELFToken.deployed().then(function(instance){
            return instance.getLockedFundsTimeStep(index);
        }).then(function(holder){
            alert('the timer step is ' + holder);
        });
    },

    handleGetCounter: function(event) {
        var index = parseInt($('#input-code').val());

        App.contracts.SELFToken.deployed().then(function(instance){
            return instance.getLockedFundsCounter(index);
        }).then(function(count){
            alert('the counter is ' + count);
        });
    },

    handleGetCounter: function(event) {
        var index = parseInt($('#input-code').val());

        App.contracts.SELFToken.deployed().then(function(instance){
            return instance.getLockedFundsCounter(index);
        }).then(function(count){
            alert('the counter is ' + count);
        });
    },

    handleQueryCopyright: function(event) {
        var address = parseInt($('#input-from-address').val());
        var code = parseInt($('input-copyright').val());

        App.contracts.SELFToken.deployed().then(function(instance){
            return instance.queryCopyright(address,code);
        }).then(function(copyright){
            alert('the result of copyright is ' + copyright);
        });
    },

    handleGetManager: function(event) {
        App.contracts.SELFToken.deployed().then(function(instance){
            return instance.getManager();
        }).then(function(manager){
            alert('the manager is ' + manager);
        });
    },

    handleTransaction: function(event) {
        var address = parseInt($('#input-to-address').val());
        var amount = parseInt($('#input-amount').val());

        App.contracts.SELFToken.deployed().then(function(instance){
            return instance.transfer(address,amount);
        }).then(function(success){
            alert('transaction finished, please check your balance from wallet. code: ' + success);
        });
    },
};

$(function() {
    $(window).load(function(){
        App.init();
    });
});

